require 'rails_helper'

RSpec.feature 'Cambia profilo', type: :feature do
    let(:user1) {create(:sithscorpion)}
    let(:user2) {create(:looper90)}

    scenario '1) user1 cambia profilo con username valido' do
        valid_username = 'aristotele'

        sign_in user1
        visit profile_path
        expect(page).to have_selector('span', text: "username: " + user1.username )

        visit edit_profile_path
        fill_in "Nome Evocatore", with: valid_username
        click_button 'Cerca'

        expect(current_path).to eq("/profile")
        expect(page).to have_selector('span', text: "username: " + valid_username ) #feedback grafico
        user1.reload
        expect(user1.username).to eq(valid_username)  #cambiamento effettivo nel db
    end

    scenario '2) user1 cerca di cambiare profilo con username già esistente nel sito' do
        og_username = user1.username
        new_username = user2.username

        sign_in user1
        visit profile_path
        expect(page).to have_selector('span', text: "username: " + og_username )
        expect(user1.username).to eq(og_username)
          
        visit edit_profile_path
        fill_in "Nome Evocatore", with: new_username
        click_button 'Cerca'
        expect(page).to have_content 'Username già in questo sito. Riprova'
        expect(current_path).to eq(edit_profile_path)

    end

    scenario '3) user1 cerca di cambiare profilo con username non esistente di LoL' do
        invalid_username = 'asfnekne121'

        sign_in user1
        old_username = user1.username
        visit edit_profile_path
        fill_in "Nome Evocatore", with: invalid_username
        click_button 'Cerca'

        expect(page).to have_content 'Username inesistente. Riprova'
        expect(current_path).to eq(edit_profile_path)
        expect(user1.username).to eq(old_username)
    
    end
end