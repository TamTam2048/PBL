# frozen_string_literal: true

class Checkout < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy

  before_create :set_slug

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :slug, presence: true
  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :email, presence: true, length: { in: 5..100 }, format: { with: VALID_EMAIL_REGEX }

  def to_param
    slug
  end

  private

  def set_slug
    loop do
      self.slug = SecureRandom.Hex(10)
      break unless Checkout.exists?(slug: slug)
    end
  end
end
