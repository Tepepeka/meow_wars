class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
      @user = User.from_omniauth(auth_params)
      if @user.present?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
      else
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