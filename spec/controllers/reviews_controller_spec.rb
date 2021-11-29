# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  login

  let(:user) { controller.current_user }
  let!(:product) { FactoryBot.create(:product, user: user) }
  let!(:review) { FactoryBot.create(:review, user: user, product: product) }
  let(:valid_attr) do
    { content: "Lorem ipsum", rating: 3.0 }
  end

  describe "POST #create" do
    describe "with valid attributes" do
      it "creates new comment" do
        expect do
          post :create, xhr: true, params: { review: FactoryBot.attributes_for(:review), product_id: product.id }
        end.to change(user.reviews, :count).by(1)
      end
    end

    describe "with invalid attributes" do
      it "not create without content" do
        post :create, xhr: true, params: { review: FactoryBot.attributes_for(:review, content: nil),
                                           product_id: product.id }
        expect(response).to redirect_to product_path(product)
      end

      it "not create without rating" do
        post :create, xhr: true, params: { review: FactoryBot.attributes_for(:review, rating: nil),
                                           product_id: product.id }
        expect(response).to redirect_to product_path(product)
      end
    end
  end

  describe "GET #edit" do
    it "return a success response" do
      get :edit, params: { product_id: product.id, id: review.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH #update" do
    describe "with valid attributes" do
      it "updates review" do
        expect do
          patch :update, params: { review: valid_attr, product_id: product.id, id: review.id }
          review.reload
        end.to change(review, :content).to(valid_attr[:content]).and change(review, :rating).to(valid_attr[:rating])
        expect(response).to redirect_to product_path(product)
      end
    end

    describe "with invalid attributes" do
      it "not update review without rating" do
        patch :update, params: { review: FactoryBot.attributes_for(:review, content: nil),
                                 product_id: product.id, id: review.id }
        expect(response).to redirect_to(edit_product_review_path(product.id, review.id))
      end

      it "not update review without content" do
        patch :update, params: { review: FactoryBot.attributes_for(:review, rating: nil),
                                 product_id: product.id, id: review.id }
        expect(response).to redirect_to(edit_product_review_path(product.id, review.id))
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes review" do
      expect do
        delete :destroy, xhr: true, params: { product_id: product.id, id: review.id }
      end.to change(product.reviews, :count).by(-1)
    end
  end
end
