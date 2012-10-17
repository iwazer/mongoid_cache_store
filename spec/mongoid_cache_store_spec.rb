# -*- coding: utf-8 -*-
require 'spec_helper'

describe MongoidCacheStore do
  describe "#new" do
    context "when omit collection_name" do
      let(:store) { MongoidCacheStore.new }

      it "should be 'rails_cache_store'" do
        store.instance_variable_get('@collection_name').should eql('rails_cache_store')
      end
    end
  end
end

describe MongoidCacheStore::CacheStore do
  context "when create MongoidCacheStore without collection_name" do
    before do
      MongoidCacheStore.new
    end
    it "should be stored in 'rails_cache_store' collection" do
      MongoidCacheStore::CacheStore.collection_name.to_s.should eql('rails_cache_store')
    end
  end
end