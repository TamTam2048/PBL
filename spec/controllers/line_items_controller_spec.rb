require "rails_helper"

RSpec.describe LineItemsController, type: :controller do
  login

  before do
    current_order = FactoryBot.create(:order, user: user)
  end

  let(:user) { controller.current_user }
  let(:product) { FactoryBot.create(:product, user: user) }

  let(:valid_attributes) do
    { quantity: "1", product_id: product.id }
  end

  describe "POST #create" do
    render_views(false)

    it "create line item" do
      post :create, params: { line_item: valid_attributes }
      expect(current_order.line_items.size).to eq(1)
    end
  end

end