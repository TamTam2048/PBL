# frozen_string_literal: true

class Checkout < ApplicationRecord
  belongs_to :user, optional: true
  has_one :order, dependent: :destroy

  before_create :set_slug

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :name, presence: true
  validates :email, presence: true, length: { in: 5..100 }, format: { with: VALID_EMAIL_REGEX }
  validates :address, presence: true
  validates :phone_number, presence: true

  def to_param
    slug
  end

  def create_charge(token)
    @amount = total * 100.0
    customer = Stripe::Customer.create(
      email: email,
      source: token
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: trim(@amount),
      description: "user #{email} has started a purchase",
      currency: "usd"
    )
  rescue Stripe::CardError => e
    errors.add(:checkout, e.message)
  end

  private

  def trim(num)
    i = num.to_i
    f = num.to_f
    i == f ? i : f
  end

  def set_slug
    loop do
      self.slug = SecureRandom.hex(10)
      break unless Checkout.exists?(slug: slug)
    end
  end
end
