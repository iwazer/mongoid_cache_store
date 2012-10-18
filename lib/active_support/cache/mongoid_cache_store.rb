# -*- coding: utf-8 -*-
require 'active_support'

module ActiveSupport
  module Cache
    class MongoidCacheStore < Store
      DEFAULT_EXPIRES_IN = 86400

      class CacheStore
        include Mongoid::Document

        attr_accessible :_id

        field :id, type: String
        field :expires, type: DateTime, default: -> { Time.now + DEFAULT_EXPIRES_IN }
      end

      def initialize options={}
        CacheStore.store_in(collection: options[:collection_name] || 'rails_cache_store')
      end

    end
  end
end