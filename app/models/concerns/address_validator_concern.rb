# frozen_string_literal: true

module AddressValidatorConcern
  extend ActiveSupport::Concern

  included do
    def address_validation
      attributes = self.attributes
      attributes.each_key do |attribute|
        next unless attribute.include?('address') &&
                    (!attributes[attribute].is_a?(Array) || attributes[attribute].size != 2 ||
                    !num?(attributes[attribute][0]) || !num?(attributes[attribute][1]))

        errors.add(attribute, 'Address only allowed in format [longitude, latitude]')
      end
    end

    def num?(num)
      !!Float(num)
    rescue StandardError
      false
    end
  end
end
