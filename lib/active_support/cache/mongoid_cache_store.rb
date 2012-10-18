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
        store_opts = {collection: options[:collection_name] || 'rails_cache_store'}
        store_opts.merge!(database: options[:database_name]) if options[:database_name].present?
        CacheStore.store_in(store_opts)
        CacheStore.default_expires_in = options[:expires_in] || DEFAULT_EXPIRES_IN
      end

      def cleanup
        CacheStore.lt(expires: Time.now).delete
      end

    end
  end
end