require 'rails_helper'

RSpec.feature "Teams", type: :system do

  let(:user) { create(:user1) }

  scenario "user crea un team" do

    login_as(user, scope: :user)
    visit root_path
    click_button 'Crea Team'

    select 'Ranked', from: 'team_mode'
    select 'Bronze', from: 'team_minRank'

    lane = find('leader-lane')

    accept_friend_button = within(lane) do
      find('img[data-lane="Top"]').click
    end

    check "jungle-checkbox"
    check "mid-checkbox"
    check "adc-checkbox"
    check "support-checkbox"

    click_button 'Pubblica'

  end
end
