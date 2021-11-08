# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user, factory: :user
    association :checkout, factory: :checkout
    status { 0 }
    subtotal { 777.77 }
  end
end
