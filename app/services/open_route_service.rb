# frozen_string_literal: true

class OpenRouteService < FaradayService
  def initialize
    super ENV['OPEN_ROUTE_URL'], ENV['OPEN_ROUTE_API_KEY']
  end

  def fetch_direction(home_address, start_coord, end_coord, profile = 'driving-car', unit = 'mi')
    @conn.post("/v2/directions/#{profile}") do |req|
      req.body = {
        "coordinates": [home_address, start_coord, end_coord],
        "units": unit
      }.to_json
    end
  end
end
