# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :checkout, optional: true
  has_many :line_items, dependent: :destroy

  enum status: { pending: 0, processing: 1, approved: 2, canceled: 3 }
  validates :status, inclusion: { in: %w[pending processing approved canceled] }

  before_save :update_subtotal

  def subtotal
    line_items.sum { |li| li.valid? ? (li.quantity * li.unit_price) : 0 }
  end

  private

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
