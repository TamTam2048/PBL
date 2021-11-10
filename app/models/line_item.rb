# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  private

  def product_present
    errors.add(:product, "is not valid") if product.nil?
  end

  def order_present
    errors.add(:order, "is not valid") if order.nil?
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = self[:unit_price] * quantity
  end
end
