# frozen_string_literal: true

module Api
  module V1
    class RidesController < ActionController::API
      include Api::V1::RidesHelper
      include RidesCacheConcern
      before_action :fetch_driver, only: [:index]
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      def index
        @rides = Ride.open
        @computed_rides = []
        @rides.each { |ride| @computed_rides.push cached_computed_ride ride }
        @computed_rides.sort! { |a, b| b['score'] <=> a['score'] }
        render json: paginated_rides
      end

      private

      def paginated_rides
        @computed_rides.paginate(page: params[:page] || 1,
                                 per_page: params[:per_page] || 5)
      end

      def record_not_found
        render json: {
          error: 'Driver not found'
        }, status: :not_found
      end

      def fetch_driver
        @driver = Driver.find(params[:driver].to_s)
      end
    end
  end
end
