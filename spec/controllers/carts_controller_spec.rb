# frozen_string_literal: true

require "rails_helper"

RSpec.describe CartsController, type: :controller do
  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {}
      expect(response).to have_http_status(:ok)
    end
  end
end
