class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: [:user,:moderator]

  #attr_accessor :riot_user, :riot_tag
  #per ora non servono

  #---------------------------#
  before_create :generate_uid

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # Altri campi se necessario
    end
  end

  private 
  #tutti i metodi definiti sotto saranno privati

  def generate_uid
    self.uid = generate_unique_uid
  end

  def generate_unique_uid
    random_uid = SecureRandom.random_number(1_000)

    while User.exists?(uid: random_uid)
      random_uid = SecureRandom.random_number(1_000)
    end

    return random_uid
  end
end
