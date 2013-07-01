class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token, :only => [:google_oauth2, :twitter, :github]

  def google_oauth2
    passthru "google"
  end

  def twitter
    passthru "twitter"
  end

  def github
    passthru "github"
  end

  def passthru provider
    access_token = request.env["omniauth.auth"].except("extra")
    Rails.logger.debug access_token.inspect.to_yaml
    unless access_token.info["email"].nil?
      @user = User.find_for_any(access_token, current_user)
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.titleize
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.#{provider}_data"] = access_token
        redirect_to new_user_registration_url
      end
    else  
      session["devise.#{provider}_data"] = access_token
      redirect_to new_user_registration_url
    end 
  end
end