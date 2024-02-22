require 'rails_helper'

RSpec.feature "Teams", type: :system do

  let(:user) { create(:user1) }

  before do
    sign_in user
  end

  scenario "User creates a new team" do
    visit '/teams/new'

    # Fill out the form fields
    select "Normal", from: "team_mode"
    select "Gold", from: "team_minRank"

    # Choose leader lane
    choose "Top"  # Or select the appropriate radio button for the leader lane

    # Select desired lanes
    check "selected_lanes[]", option: "Mid"  # For example, check the "Mid" lane

    # Submit the form
    click_button "Pubblica"

    # Expectations after form submission
    
    expect(Team.count).to eq(1)  # Assuming your application creates a new Team record upon form submission
  end
end
