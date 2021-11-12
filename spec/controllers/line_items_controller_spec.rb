# frozen_string_literal: true

require "rails_helper"

RSpec.describe LineItemsController, type: :controller do
  login

  let(:user) { controller.current_user }
  let(:current_order) { controller.current_order }
  let(:product) { FactoryBot.create(:product, user: user) }

  let(:valid_attributes) do
    { quantity: "1", product_id: product.id }
  end

  describe "POST #create" do
    it "creates a new line item" do
      post :create, xhr: true, params: { line_item: valid_attributes }
      expect(current_order.line_items.size).to eq(1)
    end
  end

  describe "PATCH #update" do
    it "updates line item" do
      post :create, xhr: true, params: { line_item: valid_attributes }
      line_item = current_order.line_items.first
      patch :update, xhr: true, params: { line_item: { quantity: "2" }, id: line_item.id }
      expect(current_order.line_items.first.quantity).to eq(2)
    end
  end

  describe "DELETE #destroy" do
    it "delete line item" do
      post :create, xhr: true, params: { line_item: valid_attributes }
      line_item = current_order.line_items.first
      delete :destroy, xhr: true, params: { id: line_item.id }
      expect(current_order.line_items.size).to eq(0)
    end
  end
end
