class User < ActiveRecord::Base

  has_many :messages
  has_many :comments

  devise :database_authenticatable, :registerable, :rememberable,
  		 :trackable, :validatable, :omniauthable

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Получить identity пользователя, если он уже существует
    identity = Identity.find_for_oauth(auth)

    # Если signed_in_resource предоставлен оно всегда переписывает
    # существующего пользователя что бы identity не была закрыта
    # случайно созданным аккаунтом.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Создать пользователя, если нужно
    if user.nil?

      email = auth.info.email
      user = User.where(:email => email).first if email

      # Создать пользователя, если это новая запись
      if user.nil?
        user = User.new(
          name: auth.info.name,
          email: email ? email : "#{auth.uid}@#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.save!
      end
    end

    # Связать identity с пользователем, если необходимо
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
end
