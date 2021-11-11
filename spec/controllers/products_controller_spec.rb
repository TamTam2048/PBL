# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  login

  let(:valid_attributes) do
    { name: "Test title!", description: "This is a test description", price: 12.5, rating: 5.0 }
  end

  let(:invalid_attributes) do
    { name: nil, description: "This is a test description", price: 12.5, rating: 5.0 }
  end

  describe "GET #index" do
    it "returns a success response" do
      FactoryBot.create(:product)
      get :index, params: {}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = FactoryBot.create(:product)
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #new" do
    it "renders new product template" do
      get :new, params: {}
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates product with valid attributes" do
      post :create, params: { product: valid_attributes }
      expect(response).to redirect_to(product_path(Product.last))
    end

    it "redirect to new_product_path with invalid attributes" do
      post :create, params: { product: invalid_attributes }
      expect(response).to redirect_to(new_product_path)
    end
  end

  describe "PATCH #update" do
    let(:user) { controller.current_user }
    let!(:product) { FactoryBot.create(:product, user: user) }

    it "updates product with valid attributes" do
      patch :update, params: { product: valid_attributes, id: product.id }
      expect(response).to redirect_to(user_path(user))
    end

    it "redirects to edit_product_path with invalid attributes" do
      patch :update, params: { product: invalid_attributes, id: product.id }
      expect(response).to redirect_to(edit_product_path(product))
    end
  end

  describe "DELETE #destroy" do
    let(:user) { controller.current_user }
    let!(:product) { FactoryBot.create(:product, user: user) }

    it "redirects to products_path" do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_path)
    end
  end
end
