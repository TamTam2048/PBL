# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  login
  let(:user) { controller.current_user }

  describe "#current_order" do
    describe "current user present" do
      it "returns the latest order of current user" do
        FactoryBot.create(:order, user: user)
        current_order = user.orders.last
        expect(current_order).to be_present
      end
    end

    describe "current user not present" do
      it "returns new order" do
        current_order = FactoryBot.build(:order)
        expect(current_order).to be_present
      end
    end
  end
end
