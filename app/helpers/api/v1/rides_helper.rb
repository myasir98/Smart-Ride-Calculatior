# frozen_string_literal: true

module Api
  module V1
    module RidesHelper
      def ride_calculator(ride, distance_service_object)
        distance_service_object = JSON.parse(distance_service_object)
        routes = distance_service_object['routes']
        computed_service_object = compute_routes_object routes
        computed_service_object[:ride_id] = ride.id
        computed_service_object[:ride_start_destination_address] = [ride.start_address, ride.destination_address]
        computed_service_object
      end

      def compute_routes_object(routes)
        rec = ActiveSupport::HashWithIndifferentAccess.new
        rec[:driving_distance] = routes.first['summary']['distance']
        rec[:driving_duration] = seconds_to_hours routes.first['summary']['duration']
        rec[:commute_distance] = routes.first['segments'].first['distance']
        rec[:commute_duration] = seconds_to_hours routes.first['segments'].first['duration']
        rec[:ride_distance] = routes.first['segments'][1]['distance']
        rec[:ride_duration] = seconds_to_hours routes.first['segments'][1]['duration']
        rec[:ride_earnings] = calculate_ride_earning rec[:ride_distance],
                                                     rec[:ride_duration]
        rec[:score] = calculate_score rec[:ride_earnings],
                                      rec[:commute_duration],
                                      rec[:ride_duration]
        rec
      end

      def calculate_ride_earning(distance, time)
        12 + 1.5 * (distance > 5 ? distance - 5 : 0) +
          0.7 * (hours_to_minutes(time) > 15 ? hours_to_minutes(time) - 15 : 0)
      end

      def calculate_score(earnings, commute, ride)
        earnings / (commute + ride)
      end

      def seconds_to_hours(time)
        Float(time) / 3600
      rescue StandardError => e
        0
      end

      def hours_to_minutes(time)
        Float(time) * 60
      rescue StandardError => e
        0
      end
    end
  end
end
