class User < ActiveRecord::Base

  has_many :messages
  has_many :comments

  devise :database_authenticatable, :registerable, :rememberable,
  		 :trackable, :validatable, :omniauthable

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get user, if it already exists
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    # Create user if needed
    if user.nil?
      email = auth.info.email
      user = User.where(:email => email).first if email
      # Create user if this is a new record
      if user.nil?
        user = User.new(
          name: auth.info.name,
          email: email ? email : "#{auth.uid}@#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.save!
      end
    end
    # Connect identity with user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
end
