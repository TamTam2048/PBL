# frozen_string_literal: true

class User < ApplicationRecord
  include Gravtastic
  gravtastic

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :checkouts, dependent: :destroy
  has_many :reviews, dependent: :destroy

  enum role: { admin: 0, user: 1 }
  validates :role, inclusion: { in: %w[admin user] }

  class << self
    def from_omniauth(auth)
      if omniauth_registered_user(auth)
        omniauth_registered_user(auth)
      elsif registered_user(auth)
        registered_user(auth)
      else
        create_omniauth_user(auth)
      end
    end

    def omniauth_registered_user(auth)
      where(provider: auth.provider, uid: auth.uid).first
    end

    def registered_user(auth)
      where(email: auth.info.email).first
    end

    def create_omniauth_user(auth)
      create(
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        image: auth.info.image,
        provider: auth.provider,
        name: auth.info.name
      )
    end
  end
end
