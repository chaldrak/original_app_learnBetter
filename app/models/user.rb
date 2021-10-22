class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :omniauthable, omniauth_providers: %i(google facebook)

  before_create :create_is_admin_default

  validates :name, length: {minimum: 6, maximum: 20}
  has_many :questions, dependent: :destroy
  

  def create_is_admin_default
    self.is_admin = false
    self.picture = Faker::Avatar.image(size: "100x100", format: "jpg")
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)
    unless user
      user = User.new(
                      email: auth.info.email,
                      name: auth.info.name,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20],
                    )
      user.skip_confirmation!
    end
    user.save
    user
  end

  def self.find_for_facebook(auth)

    unless auth.info.email
      auth.info.email = "#{auth.info.name.split(' ').join}@facebook.com"
    end
    
    user = User.where("email= ?", auth.info.email).first

    if user
      return user
    else
      user = User.new(
        email: auth.info.email,
        name: auth.info.name,
        provider: auth.provider,
        uid:      auth.uid,
        password: Devise.friendly_token[0, 20],
      )
      user.skip_confirmation!
    end
    user.save
    user
  end
end
