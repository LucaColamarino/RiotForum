class User < ApplicationRecord
  rolify
  
  has_many :newposts, dependent: :destroy
  #amicizie
  has_many :invitations, dependent: :destroy
  #has_many :pending_invitations, -> {where confirmed: false}, class_name: "Invitation", foreign_key: "friend_id", dependent: :destroy

  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :team, foreign_key: 'leader_id', dependent: :destroy, inverse_of: :leader
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
    friend_ids = Invitation.where(user_id:id,confirmed: true).pluck(:friend_id) + Invitation.where(friend_id:id,confirmed: true).pluck(:user_id)
    User.where(id: friend_ids)
  end

  def friend_with?(user)
    Invitation.confirmed?(id, user.id)
  end

  def send_invitation(user)
    Invitation.new(user_id: current_user.id, friend_id: user.id)
  end

  def pending_sent?(user)
    id1 = id
    id2 = user.id
    case1 = !Invitation.where(user_id: id1, friend_id: id2, confirmed: false).empty?
    case2 = !Invitation.where(user_id: id2, friend_id: id1, confirmed: false).empty?
    case1 || case2
  end

  def banned?
    banned
  end

  def has_team?
    !team_id.nil?
  end

  def isLeader?(team)
    if team.is_a?(Team)
      team_id == team.id
    end
  end

  def candidato?(teamid)
    if teamid.is_a?(Integer)
      return Request.find_by(user_id:id,team_id:teamid)
    end
    false
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
