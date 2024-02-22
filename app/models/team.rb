class Team < ApplicationRecord
    before_destroy :update_related_records
    belongs_to :leader, class_name: "User"
    #has_many :members, class_name: "User"
    has_one :ad, dependent: :destroy
    has_one :messaggioteam, dependent: :destroy

    has_many :request, dependent: :destroy

    serialize :lanes, type: Array, coder: JSON
    serialize :comp, type: Hash, coder: JSON
    
    validates :leader, presence: true

    after_initialize :set_default_comp_values, unless: :persisted?

    private

    def set_default_comp_values
        self.comp ||= {
          "Top" => nil,
          "Jungle" => nil,
          "Mid" => nil,
          "Adc" => nil,
          "Support" => nil
        }
    end

    def update_related_records

      User.where(team_id: self.id).update_all(team_id: nil)
    end

end
