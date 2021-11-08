# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations and validations" do
    it "has a valid factories" do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "is invalid with a duplicate email" do
      FactoryBot.create(:user, email: "user@gmail.com")
      user = FactoryBot.build(:user, email: "user@gmail.com")
      expect(user).not_to be_valid
    end

    it "has many products" do
      relation = described_class.reflect_on_association(:products)
      expect(relation.macro).to eq :has_many
    end

    it "has many orders" do
      relation = described_class.reflect_on_association(:orders)
      expect(relation.macro).to eq :has_many
    end

    it "has many checkouts" do
      relation = described_class.reflect_on_association(:checkouts)
      expect(relation.macro).to eq :has_many
    end

    it "has many reviews" do
      relation = described_class.reflect_on_association(:reviews)
      expect(relation.macro).to eq :has_many
    end
  end

  auth_hash = OmniAuth::AuthHash.new({
                                       provider: "facebook",
                                       uid: "1234",
                                       info: {
                                         email: "user@example.com",
                                         name: "MatthewLuong"
                                       }
                                     })

  describe "#from_omniauth" do
    it "retrieves existing user" do
      user = FactoryBot.create(:user, provider: "facebook", uid: "1234")
      omniauth_user = described_class.from_omniauth(auth_hash)
      expect(user).to eq(omniauth_user)
    end

    it "creates a new user if one doesn't exist" do
      expect(described_class.count).to eq(0)
      described_class.from_omniauth(auth_hash)
      expect(described_class.count).to eq(1)
    end
  end
end
