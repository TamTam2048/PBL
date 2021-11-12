# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    association :order, factory: :order
    association :product, factory: :product
    quantity        { 1 }
    unit_price      { Faker::Number.rand_in_range(0.0, 999999.99).round(2) }
    total_price     { Faker::Number.rand_in_range(0.0, 999999.99).round(2) }
  end
end
