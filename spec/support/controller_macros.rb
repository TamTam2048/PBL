# frozen_string_literal: true

module ControllerMacros
  def login
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end
  end

  def admin_login
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user, role: 0)
      sign_in user
    end
  end
end
