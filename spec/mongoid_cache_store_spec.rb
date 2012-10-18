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

  describe "expires field" do
    let(:now_time) { Time.parse('2012-01-01 13:00:00') }
    before do
      Time.should_receive(:now).any_number_of_times.and_return(now_time)
    end
    context "MongoidCacheStore#new without expires_in option" do
      let!(:store) { MongoidCacheStore.new }
      it "should set current time + MongoidCacheStore::DEFAULT_EXPIRES_IN as default" do
        c = MongoidCacheStore::CacheStore.create(_id: "KEY_STRING")
        c.reload.expires.should == now_time + MongoidCacheStore::DEFAULT_EXPIRES_IN
      end
    end
  end
end