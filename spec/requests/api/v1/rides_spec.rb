# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/rides', type: :request do
  before(:all) do

  end
  path '/api/v1/rides' do
    get('Returns paginated JSON list of rides in descending score order for a given driver') do
      parameter name: :driver, in: :query
      parameter name: :page, in: :query
      parameter name: :per_page, in: :query
      produces('application/json')
      response(200, 'successful') do
        let(:driver) { create(:driver).id }
        let(:page) { 1 }
        let(:per_page) { 2 }
        schema type: :array,
               "items":
                  {
                    "type": 'object',
                    "properties": {
                      "driving_distance": {
                        "type": 'number'
                      },
                      "driving_duration": {
                        "type": 'number'
                      },
                      "commute_distance": {
                        "type": 'number'
                      },
                      "commute_duration": {
                        "type": 'number'
                      },
                      "ride_distance": {
                        "type": 'number'
                      },
                      "ride_duration": {
                        "type": 'number'
                      },
                      "ride_earnings": {
                        "type": 'number'
                      },
                      "score": {
                        "type": 'number'
                      },
                      "ride_id": {
                        "type": 'integer'
                      },
                      "ride_start_destination_address": {
                        "type": 'array',
                        "items": [
                          {
                            "type": 'array',
                            "items": [
                              {
                                "type": 'string'
                              },
                              {
                                "type": 'string'
                              }
                            ]
                          },
                          {
                            "type": 'array',
                            "items": [
                              {
                                "type": 'string'
                              },
                              {
                                "type": 'string'
                              }
                            ]
                          }
                        ]
                      }
                    },
                    "required": %w[
                      driving_distance
                      driving_duration
                      commute_distance
                      commute_duration
                      ride_distance
                      ride_duration
                      ride_earnings
                      score
                      ride_id
                      ride_start_destination_address
                    ]
                  }

        run_test!
      end
      response(404, 'Driver Not Found') do
        let(:driver) { nil }
        let(:page) { 1 }
        let(:per_page) { 2 }
        schema type: :object,
               "properties": {
                 "error": {
                   "type": 'string'
                 }
               },
               "required": [
                 'error'
               ]
        run_test!
      end
    end
  end
end
