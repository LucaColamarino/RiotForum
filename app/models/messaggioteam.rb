class Messaggioteam < ApplicationRecord
    belongs_to :team, class_name: 'Team', foreign_key: 'team_id'
    
end
