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
