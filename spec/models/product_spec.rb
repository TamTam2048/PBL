# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  describe "#blank_star" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:product) { FactoryBot.create(:product, user: user, rating: 4.0) }

    it "returns correct number of blank stars" do
      expect(product.blank_stars).to eq(1)
    end
  end
end
