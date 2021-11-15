# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present

  private

  def product_present
    errors.add(:product, "is not valid") if product.nil?
  end

  def order_present
    errors.add(:order, "is not valid") if order.nil?
  end
end
