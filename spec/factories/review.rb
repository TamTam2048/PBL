# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    association :user, factory: :user
    association :product, factory: :product
    content { Faker::Movie.quote }
    rating  { Faker::Number.rand_in_range(1.0, 5.0).round(1) }
  end
end
