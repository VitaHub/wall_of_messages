class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)
        sign_in_and_redirect @user, event: :authentication
      end
    }
  end

  [:twitter, :facebook, :vkontakte].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
      super resource
  end
end