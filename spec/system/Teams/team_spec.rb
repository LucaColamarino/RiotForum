require 'rails_helper'

RSpec.feature "Teams", type: :system do

  let(:user) { create(:user) }
  let(:user1) { create(:user1) }

  describe "Team" do
    scenario "team functions" do

      sign_in user

      visit root_path
      click_button "Crea Team"

      select "Normal", from: "team_mode"
      select "Gold", from: "team_minRank"

      find(".leader-lane[data-lane='Top']").click

      find(".lanes-checkbox[data-lane='Jungle']").click
      find(".lanes-checkbox[data-lane='Mid']").click
      find(".lanes-checkbox[data-lane='Adc']").click
      find(".lanes-checkbox[data-lane='Support']").click

      sleep 2

      click_button "Pubblica"

      expect(page).to have_current_path(teams_path)
      
      expect(Team.count).to eq(1)

      #attiva il menù dropdown, aspetta 1 secondo e poi preme su logout.
      #l'attesa serve per dargli tempo di premere
      find('.w3-dropdown-hover').hover
      sleep 1
      click_button 'Logout'

      sign_in user1

      expect(page).to have_current_path(root_path)

      click_button 'VEDI TUTTI'

      annuncio = find(".annuncio", text: user.username)
      within annuncio do

        find(".leader-lane[data-lane='Support']").click
        sleep 2
        click_button "Candidati"
      end

      expect(page).to have_current_path(profile_path)

      find('.w3-dropdown-hover').hover
      sleep 1
      click_button 'Logout'

      sign_in user

      sleep 1

      visit profile_path
      sleep 2

      click_button 'Accetta'

      visit root_path

      click_button 'Il tuo Team'

      sleep 2

      support_lane = find('.SupportLane')
      within support_lane do

        expect(support_lane).to have_text user1.username
        find('button.dropdown-toggle-split').click
        sleep 1
        within('.dropdown-menu') do
          click_button 'Espelli'
        end
      end

      expect(user1.team_id).to be_nil

      sleep 1
      
      click_button "Smantella Team"

      expect(page).to have_current_path(root_path)

      sleep 1

      expect(user.team_id).to be_nil
      expect(page).to have_text "Crea Team"

    end
  end
end
