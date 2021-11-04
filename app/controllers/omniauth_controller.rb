class OmniauthController < Devise::OmniauthCallbacksController
  # For some reason this method is not working. It jumps right in the failure method
  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      flash[:error]='There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end
end