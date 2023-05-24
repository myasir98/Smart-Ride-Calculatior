# frozen_string_literal: true

class Driver < ApplicationRecord
  include AddressValidatorConcern

  validates :home_address, presence: true

  validate :address_validation
end
