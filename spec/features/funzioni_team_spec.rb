require 'rails_helper'


RSpec.feature "Crea team", type: :feature do
    let(:user) { create(:member1) }
    #let(:team) { create(:team1) }

    before(:each) do
        sign_in user
    end

    scenario "User with a team tries to create another team" do
        #non ho il factory team
        team_id = user.team_id
        visit '/teams/new'
        expect(response).to redirect_to(root_path)
        expect(user.reload.team_id).to eq(team_id)
    end
end