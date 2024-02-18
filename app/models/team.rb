class Team < ApplicationRecord
    belongs_to :leader, class_name: "User"
    #has_many :members, class_name: "User"
    has_one :ad, dependent: :destroy

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

end
