# frozen_string_literal: true

Product.delete_all
User.delete_all
5.times do |i|
  user = User.create!(name: Faker::Name.name, email: "user#{i}@gmail.com", password: "user123", role: 1)
  5.times do |n|
    user.products.create!(name: "Product#{n}", description: Faker::Lorem.sentence(word_count: 70), price: 7.77, rating: 5.0)
  end
end

5.times do |i|
  User.create!(name: Faker::Name.name, email: "admin#{i}@gmail.com", password: "admin123", role: 0)
end