# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }

  def blank_stars
    5 - rating.to_i
  end
end
