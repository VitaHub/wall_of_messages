Devise.setup do |config|

  # ==> OmniAuth
  config.omniauth :facebook, "502293703309953", "74aec5d15e81b0abba40b95b7500aa1c"
  config.omniauth :vkontakte, "5509329", "cDktjKGKEQn2PV9uZCAD", scope: "email"
  
  # ==> Mailer Configuration
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  # ==> ORM configuration
  require 'devise/orm/active_record'

  # ==> Configuration for any authentication mechanism
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]

  # ==> Configuration for :database_authenticatable
   config.stretches = Rails.env.test? ? 1 : 11

  # ==> Configuration for :confirmable
  config.reconfirmable = true

  # ==> Configuration for :rememberable
  config.expire_all_remember_me_on_sign_out = true

  # ==> Configuration for :validatable
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # ==> Configuration for :recoverable
  config.reset_password_within = 6.hours

  # ==> Navigation configuration
  config.sign_out_via = :delete
end
