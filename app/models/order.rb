# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :checkout, optional: true
  has_many :line_items, dependent: :destroy

  enum status: { pending: 0, processing: 1, approved: 2, canceled: 3 }
  validates :status, inclusion: { in: %w[pending processing approved canceled] }
end
