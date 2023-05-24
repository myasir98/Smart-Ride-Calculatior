# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RidesController, type: :controller do
  describe 'GET /rides' do
    before(:each) do
      @ride = create(:ride)
      @driver = create(:driver)
      get :index, params: { driver: @driver.id }
    end
    it 'Should return a valid JSON response' do
      response.header['Content-Type'].should include 'application/json'
    end
    it 'Should Cache ride locations and commute in memory' do
      expect(CacheService.new.cache_exists?([@driver.home_address,
                                             @ride.start_address,
                                             @ride.destination_address].to_s)).to be(true)
    end
    it 'Should return paginated response when page and per_page is sent in query' do
      5.times { create(:ride) }
      get :index, params: { driver: @driver.id, per_page: 2 }
      expect(JSON.parse(response.body).size).to be 2
    end
    it 'Should generate 404 error if driver not found' do
      get :index
      expect(response.status).to be 404
    end
  end
end
# ActiveSupport::Cache::MemoryStore
