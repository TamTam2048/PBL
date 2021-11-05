# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end
