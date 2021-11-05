# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      generic_callback("google_oauth2")
    end

    def facebook
      generic_callback("facebook")
    end

    def generic_callback(provider)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to new_user_registration_url
      end
    end

    def failure
      flash[:error] = "There was a problem signing you in. Please register or try signing in later."
      redirect_to new_user_registration_url
    end
  end
end
