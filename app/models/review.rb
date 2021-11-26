# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5 }

  after_save :update_product_rating

  delegate :update_product_rating, to: :product
end
