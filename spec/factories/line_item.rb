# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    association :order, factory: :order
    association :product, factory: :product
    quantity        { 1 }
  end
end
