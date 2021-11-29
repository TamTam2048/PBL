# frozen_string_literal: true

require "rails_helper"

RSpec.describe Checkout, type: :model do
  let(:user) { FactoryBot.create(:user) }

  let(:card_token) do
    Stripe::Token.create({ card: { number: "4242424242424242", exp_month: 11, exp_year: 2025, cvc: "314" } })
  end

  describe "#create_charge" do
    it "creates a customer" do
      customer = Stripe::Customer.create({ email: user.email, source: card_token })
      allow(customer).to receive(:email).and_return(user.email)
    end

    it "creates a charge" do
      customer = Stripe::Customer.create({ email: user.email, source: card_token })
      charge = Stripe::Charge.create(customer: customer.id, amount: 500,
                                     description: "user #{customer.email} has started a purchase", currency: "usd")
      allow(charge).to receive(:status).and_return(charge.status)
      expect(charge.status).to eq("succeeded")
    end
  end

  describe "#trim" do
    it "returns an integer number with float input" do
      checkout = FactoryBot.create(:checkout)
      a = 500.0
      expect(checkout.trim(a)).to eq(500)
    end
  end
end
