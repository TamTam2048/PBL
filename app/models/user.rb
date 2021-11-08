# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :checkouts, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.image = auth.info.image
      user.provider = auth.provider
      user.name = auth.info.name
    end
  end
end
