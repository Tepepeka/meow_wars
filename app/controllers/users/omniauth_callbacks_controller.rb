class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
      @user = User.from_omniauth(auth_params)
      if @user.persisted?
          sign_out_all_scopes
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
      else
          session["devise.github_data"] = auth_params
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
  end

  def google_oauth2
      @user = User.from_omniauth(auth_params)
      if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
      else
          session["devise.google_oauth2_data"] = auth_params.except('extra')
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
  end

  def failure
      redirect_to root_path
  end

  #######
  private
  #######
  
  def auth_params
      request.env["omniauth.auth"]
  end

end