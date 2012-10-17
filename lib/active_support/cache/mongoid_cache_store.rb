# -*- coding: utf-8 -*-
require 'active_support'

module ActiveSupport
  module Cache
    class MongoidCacheStore < Store

      def initialize collection_name='rails_cache_store'
        @collection_name = collection_name
      end

    end
  end
end