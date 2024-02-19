class Team < ApplicationRecord
    before_destroy :update_related_records
    belongs_to :leader, class_name: "User",dependent: :destroy
    #has_many :members, class_name: "User"
    has_one :ad, dependent: :destroy
    has_one :messaggioteam

    has_many :request, dependent: :destroy

    serialize :lanes, type: Array, coder: JSON
    serialize :comp, type: Hash, coder: JSON
    
    validates :leader, presence: true
    



    def initialize(attributes = nil)

        super
        @comp = {
            "Top" => nil,
            "Jungle" => nil,
            "Mid" => nil,
            "Adc" => nil,
            "Support" => nil
        }
    end
    private
    def update_related_records
      # Trova tutti i record con la relazione `belongs_to`
      # e aggiorna l'attributo desiderato
      User.where(team_id: self.id).update_all(team_id: nil)
      # Puoi aggiungere altre logiche per aggiornare altri record con altre relazioni `belongs_to`
    end

end
