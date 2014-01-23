class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :twitter, :github]

  def self.find_for_any(access_token, signed_in_resource=nil)
    Rails.logger.debug access_token.inspect.to_yaml
    user = User.where(:provider => access_token.provider, :uid => access_token.uid).first

    unless user
      user = User.create!(
             provider:access_token.provider,
             uid:access_token.uid,
             name: access_token.info["name"],
             email: access_token.info["email"],
             password: Devise.friendly_token[0,20]
            )
    end
    user
  end

  # Just in case
  # def self.find_for_google(access_token, signed_in_resource=nil)
  # end

  # def self.find_for_twitter(access_token, signed_in_resource=nil)
  # end

  # def self.find_for_github(access_token, signed_in_resource=nil)
  # end
end
