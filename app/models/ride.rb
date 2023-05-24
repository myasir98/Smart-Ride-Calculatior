# frozen_string_literal: true

class Ride < ApplicationRecord
  include AddressValidatorConcern
  enum status: %w[open close in_progress]
  validates :start_address, :destination_address, presence: true

  validate :address_validation
end
