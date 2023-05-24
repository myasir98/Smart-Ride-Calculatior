# frozen_string_literal: true

class FaradayService
  def initialize(url, auth = false)
    @conn = Faraday.new(
      url: url,
      headers: { 'Content-Type' => 'application/json' }
    )
    @conn.headers['Authorization'] = auth if auth
  end
end
