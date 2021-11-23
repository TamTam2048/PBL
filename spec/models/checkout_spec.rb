# frozen_string_literal: true

require "rails_helper"

RSpec.describe Checkout, type: :model do
  let(:user) { FactoryBot.create(:user) }

  let(:card_token) {
    Stripe::Token.create({ card: { number: "4242424242424242", exp_month: 11, exp_year: 2025, cvc: "314" } })
  }

  describe "#create_charge" do
    it "creates a customer" do
      customer = Stripe::Customer.create({
                                           email: user.email,
                                           source: card_token
                                         })
      expect(customer.email).to eq(user.email)
      # expect do
      #   Stripe::Charge.create(customer: customer.id, amount: 200, currency: "usd")
      # end.not_to raise_error
    end

  end
end
