require 'rails_helper'

RSpec.feature 'Permessi User', type: :feature do
    let(:user) { build(:user30) }        #non ha l'username
    let(:full_user) { build(:user31) } #ha l'username


    scenario "Registrarsi senza inserire username rimanda a edit_profile" do
        sign_up user
        fill_in "Nome Evocatore", with: user.username
        click_button 'Cerca'
        expect(page).to have_content 'username: '+user.username
    end

end