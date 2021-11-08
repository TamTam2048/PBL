# frozen_string_literal: true

FactoryBot.define do
  factory :checkout do
    association :user, factory: :user
    name         { Faker::Internet.name }
    email        { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    address      { Faker::Address.full_address }
    total        { 777.77 }
    slug         { Faker::Internet.uuid }
  end
end
