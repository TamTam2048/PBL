# frozen_string_literal: true

require "rails_helper"

RSpec.describe CheckoutsController, type: :controller do
  login

  let(:user) { controller.current_user }
  let(:seller) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product, user: seller) }

  let(:valid_attributes) do
    { name: user.name, email: user.email, address: "", phone_number: "" }
  end

  describe "GET #index" do
    before do
      5.times do
        checkout = FactoryBot.create(:checkout, user: user)
        FactoryBot.create(:order, user: user, checkout: checkout)
      end
    end

    it "returns a list of checkouts" do
      checkouts = Checkout.all
      get :index, params: {}
      expect(assigns(:checkouts)).to match_array(checkouts)
    end
  end

  describe "GET #show" do

    it "returns a success response" do
      checkout = FactoryBot.create(:checkout, user: user)
      FactoryBot.create(:order, user: user, checkout: checkout)
      get :show, params: { slug: checkout.slug }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #new" do
    it "renders new checkout template" do
      order = FactoryBot.create(:order, user: user)
      get :new, params: { order_id: order.id }
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates checkout" do
      order = FactoryBot.create(:order, user: user, checkout: nil)
      FactoryBot.create(:line_item, order: order, product: product)
      expect do
        post :create, params: { checkout: valid_attributes, order_id: order.id }
      end.to change(Checkout, :count).by(1)
    end
  end
end
