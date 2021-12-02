# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::HomeController, type: :controller do
  admin_login

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to have_http_status(:ok)
    end
  end
end
