# frozen_string_literal: true

FactoryBot.define do
  factory :ride do
    start_address { [-105.147990, 39.851867] }
    destination_address { [-105.129289, 39.842071] }
    status { 'open' }
  end
end
