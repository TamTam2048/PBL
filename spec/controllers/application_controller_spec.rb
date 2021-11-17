# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  describe "#current_order" do
    describe "current user present" do
      login

      it "returns the latest order of current user" do
        user = controller.current_user
        order = FactoryBot.create(:order, user: user)
        expect(controller.current_order).to eq(order)
      end
    end

    describe "current user not present" do
      it "returns new order" do
        expect(controller.current_order).to be_present
      end
    end
  end
end
