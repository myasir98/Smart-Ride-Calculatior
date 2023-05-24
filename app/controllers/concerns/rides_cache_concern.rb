# frozen_string_literal: true

module RidesCacheConcern
  extend ActiveSupport::Concern

  included do
    def cached_computed_ride(ride)
      cache_key = [@driver.home_address, ride.start_address, ride.destination_address]
      cache = CacheService.new
      if cache.cache_exists? cache_key
        return JSON.parse(cache.fetch_cache(cache_key).gsub('=>', ':').gsub(/\bnil\b/, 'null'))
      end

      value = ride_calculator(
        ride, OpenRouteService.new.fetch_direction(@driver.home_address, ride.start_address,
                                                   ride.destination_address).body
      )
      cache.set_cache cache_key, value
      value
    end
  end
end
