# -*- coding: utf-8 -*-
require 'active_support'

module ActiveSupport
  module Cache
    class MongoidCacheStore < Store
      DEFAULT_EXPIRES_IN = 86400

      class CacheStore
        include Mongoid::Document
        @default_expires_in = DEFAULT_EXPIRES_IN

        attr_accessible :_id, :expires, :data

        field :id, type: String
        field :expires, type: DateTime, default: -> { Time.now + self.class.default_expires_in }
        field :data, type: Moped::BSON::Binary, default: Moped::BSON::Binary.new(:generic,Marshal.dump({}))

        def self.default_expires_in= value
          @default_expires_in = value
        end
        def self.default_expires_in
          @default_expires_in
        end
      end

      def initialize options={}
        super
        store_opts = {collection: options[:collection_name] || 'rails_cache_store'}
        store_opts.merge!(database: options[:database_name]) if options[:database_name].present?
        CacheStore.store_in(store_opts)
        CacheStore.default_expires_in = options[:expires_in] || DEFAULT_EXPIRES_IN
      end

      def cleanup
        CacheStore.lt(expires: Time.now).delete
      end

      def clear
        CacheStore.delete_all
      end

      def read_entry key, options=nil
        doc = CacheStore.where(_id: key).gt(expires: Time.now).first
        ActiveSupport::Cache::Entry.new(unpack(doc.data)) if doc
      end

      def write_entry key, entry, options
        expires = Time.now + (options[:expires_in] || DEFAULT_EXPIRES_IN)
        doc = CacheStore.where(_id: key).first
        if doc
          doc.update_attributes(data: pack(entry.value), expires: expires)
        else
          CacheStore.create(_id: key, data: pack(entry.value), expires: expires).present?
        end
      end

      def delete_entry key, options=nil
        CacheStore.where(_id: key).delete
      end

      def delete_matched pattern, options=nil
        CacheStore.any_of(_id: pattern).delete
      end

      private

      def pack data
        Moped::BSON::Binary.new(:generic,Marshal.dump(data))
      end

      def unpack packed
        Marshal.load(StringIO.new(packed.to_s))
      end
    end
  end
end