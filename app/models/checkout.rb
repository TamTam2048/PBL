# frozen_string_literal: true

class Checkout < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :slug, presence: true
  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :email, presence: true, length: { in: 5..100 }, format: { with: VALID_EMAIL_REGEX }
end
