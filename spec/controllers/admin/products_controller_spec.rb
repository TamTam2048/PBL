# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::ProductsController, type: :controller do
  admin_login

  let(:user) { FactoryBot.create(:user) }
  let!(:product) { FactoryBot.create(:product, user: user) }
  let(:valid_attr) do
    { name: "guitar", description: "a good-looking guitar", price: 500.5, rating: 2.7 }
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #edit" do
    it "renders edit product template" do
      get :edit, params: { id: product.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH #update" do
    describe "with valid attributes" do
      it "updates product with valid name" do
        expect do
          patch :update, params: { product: valid_attr, id: product.id }
          product.reload
        end.to change(product, :name).to(valid_attr[:name])
      end

      it "updates product with valid description" do
        expect do
          patch :update, params: { product: valid_attr, id: product.id }
          product.reload
        end.to change(product, :description).to(valid_attr[:description])
      end

      it "updates product with valid price" do
        expect do
          patch :update, params: { product: valid_attr, id: product.id }
          product.reload
        end.to change(product, :price).to(valid_attr[:price])
      end

      it "updates product with valid rating" do
        expect do
          patch :update, params: { product: valid_attr, id: product.id }
          product.reload
        end.to change(product, :rating).to(valid_attr[:rating])
      end
    end

    describe "with invalid attributes" do
      it "not update without name" do
        patch :update, params: { product: FactoryBot.attributes_for(:product, name: ""), id: product.id }
        expect(response).to redirect_to edit_admin_product_path(product)
      end

      it "not update with invalid rating" do
        patch :update, params: { product: FactoryBot.attributes_for(:product, rating: 0), id: product.id }
        expect(response).to redirect_to edit_admin_product_path(product)
      end

      it "not update with invalid price" do
        patch :update, params: { product: FactoryBot.attributes_for(:product, price: 0), id: product.id }
        expect(response).to redirect_to edit_admin_product_path(product)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes product" do
      expect do
        delete :destroy, params: { id: product.id }
      end.to change(Product, :count).by(-1)
    end
  end
end
