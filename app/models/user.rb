class User < ApplicationRecord
  rolify
  
  has_many :newposts
  #amicizie
  has_many :invitations
  has_many :pending_invitations, -> {where confirmed: false}, class_name: "Invitation", foreign_key: "friend_id"

  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :team, foreign_key: 'leader_id', dependent: :nullify
  belongs_to :team, optional: true

  has_many :request, dependent: :destroy

  #---------------------------#
  before_create :generate_uid

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # Altri campi se necessario
    end
  end

  def friends
    friendship_sent = Invitation.where(user_id: id, confirmed: false).pluck(:friend_id)
    friendship_received = Invitation.where(friend_id: id, confirmed: false).pluck(:user_id)
    ids = friendship_sent + friendship_received
    User.where(id: ids)
  end

  def friend_with?(user)
    Invitation.confirmed?(id, user.id)
  end

  def send_invitation(user)
    Invitation.new(user_id: current_user.id, friend_id: user.id)
  end

  def banned?
    banned
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
