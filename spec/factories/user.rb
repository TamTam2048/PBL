# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email    { Faker::Internet.email }
    name     { Faker::Name.name }
    password { Faker::Internet.password(min_length: 10) }
    role     { 1 }
  end
end
