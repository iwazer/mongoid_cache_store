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