# -*- coding: utf-8 -*-
require 'spec_helper'

describe MongoidCacheStore do
  describe "#new" do
    context "when omit collection_name" do
      before { MongoidCacheStore.new }
      it "should be 'rails_cache_store'" do
        MongoidCacheStore::CacheStore.collection_name.to_s.should eql('rails_cache_store')
      end
    end

    context "with collection_name" do
      before { MongoidCacheStore.new(collection_name: 'cache_store_collection') }
      it "should be specified collection" do
        MongoidCacheStore::CacheStore.collection_name.to_s.should eql('cache_store_collection')
      end
    end
  end
end

describe MongoidCacheStore::CacheStore do
  describe "id field" do
    def create
      MongoidCacheStore::CacheStore.create(_id: "KEY_STRING")
    end
    let(:model) { create }
    it "should be able to store as cache key" do
      model.reload.id.should eql("KEY_STRING")
    end
    before do
      model
    end
    it "should be unique field" do
      expect { create }.to raise_error(/duplicate key/)
    end
  end
end