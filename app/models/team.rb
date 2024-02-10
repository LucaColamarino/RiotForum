class Team < ApplicationRecord
    has_one :leader, class_name: "User"
    has_many :users, dependent: :destroy
    
    validates :leader, presence: true
    validate :validate_player_count

    #il primo membro del team (inserito durante la creazione) è considerato il leader
    after_create :set_leader

    private

    def set_leader

        @leader ||= users.first
    end

    def validate_player_count
        errors.add(:players, "Can't exceed 4") if players.size > 4
    end
end
