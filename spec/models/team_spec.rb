require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:user) { create(:user) }

  let(:valid_params) do
    {
    team: {
        leader_id: 1,
        mode: 'Normal',
        minRank: 'Silver',
        leader_lane: 'Top',
        lanes: ['Top', 'Mid']
    }
    }
  end

  describe 'validations' do

    before do

      team = Team.new  
      team.leader_id = user.id
      team.save!
    end

    it 'validates presence of leader' do

      expect(Team.last.leader_id).to eq(user.id)
    end
  
    it 'initializes the comp to an empty hash' do

      expect(Team.last.comp).to eq({})
    end

  end
  
end
