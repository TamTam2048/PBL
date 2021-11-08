# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    association :user, factory: :user
    name         { Faker::Internet.name }
    description  { Faker::Movie.quote }
    price        { Faker::Number.rand_in_range(0.0, 999999.99).round(2) }
    rating       { Faker::Number.rand_in_range(1.0, 5.0).round(1) }
    rating_count { 100 }
  end
end
