require 'rails_helper'

RSpec.feature "Teams", type: :feature do

  let(:user) { create(:user1) }

  before do
    sign_in user
  end

  scenario "User creates a new team" do
    visit '/teams/new'

    # Fill out the form fields
    select "Normal", from: "team_mode"
    select "Gold", from: "team_minRank"

    find('.leader-lane[data-lane="Top"]').click  

    check "team[selected_lanes][]", option: "Mid"  

    click_button "Pubblica"

    # Expectations after form submission
    
    expect(Team.count).to eq(1)  # Assuming your application creates a new Team record upon form submission
    expect(Team.last.mode).to eq('Normal')
  end
end
