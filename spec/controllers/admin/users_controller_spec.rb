# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  admin_login

  let(:admin) { controller.current_user }
  let(:user) { FactoryBot.create(:user) }
  let(:valid_attr) do
    { name: "user1", email: "user1@gmail.com", role: "admin" }
  end

  describe "GET#index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH #update" do
    describe "with valid attributes" do
      it "updates with valid name" do
        expect do
          patch :update, params: { user: valid_attr, id: user.id }
          user.reload
        end.to change(user, :name).to(valid_attr[:name])
      end

      it "updates with valid email" do
        expect do
          patch :update, params: { user: valid_attr, id: user.id }
          user.reload
        end.to change(user, :email).to(valid_attr[:email])
      end

      it "updates with valid role" do
        expect do
          patch :update, params: { user: valid_attr, id: user.id }
          user.reload
        end.to change(user, :role).to(valid_attr[:role])
      end
    end

    describe "with invalid attributes" do
      it "not update with invalid name" do
        patch :update, params: { user: FactoryBot.attributes_for(:user, name: ""), id: user.id }
        expect(response).to redirect_to admin_users_path
      end

      it "not update with invalid email" do
        patch :update, params: { user: FactoryBot.attributes_for(:user, email: ""), id: user.id }
        expect(response).to redirect_to admin_users_path
      end

      it "not update with invalid role" do
        patch :update, params: { user: FactoryBot.attributes_for(:user, role: ""), id: user.id }
        expect(response).to redirect_to admin_users_path
      end
    end
  end
end
