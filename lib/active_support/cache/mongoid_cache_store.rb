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

      def initialize collection_name='rails_cache_store'
        @collection_name = collection_name
        CacheStore.store_in(collection: @collection_name)
      end

    end
  end
end