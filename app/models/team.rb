class Team < ApplicationRecord
    belongs_to :leader, class_name: "User"
    #has_many :members, class_name: "User"

    serialize :lanes, type: Array, coder: JSON
    serialize :comp, type: Hash, coder: JSON
    
    validates :leader, presence: true

    def initialize(attributes = nil)

        super
        @comp = Hash.new
        @comp["Top"] = nil
        @comp["Jungle"] = nil
        @comp["Mid"] = nil
        @comp["Adc"] = nil
        @comp["Support"] = nil
    end

end
