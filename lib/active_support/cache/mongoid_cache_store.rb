# -*- coding: utf-8 -*-
require 'active_support'

module ActiveSupport
  module Cache
    class MongoidCacheStore < Store

      class CacheStore
        include Mongoid::Document

        attr_accessible :_id

        field :id, type: String
      end

      def initialize options={}
        CacheStore.store_in(collection: options[:collection_name] || 'rails_cache_store')
      end

    end
  end
end