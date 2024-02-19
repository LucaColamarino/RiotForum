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

RSpec.feature 'Cambia profilo', type: :feature do
    let(:sithscorpion) {create(:sithscorpion)}
    let(:looper90) {create(:looper90)}

    scenario '1) sithscorpion cambia profilo con username non già esistente nel sito e valido di LoL' do
        
    end

    scenario 'sithscorpion cerca di cambiare profilo con username già esistente nel sito' do
        og_username = sithscorpion.username
        new_username = looper90.username

        sign_in sithscorpion
        visit profile_path
        expect(current_path).to eq("/profile")
        expect(page).to have_selector('span', text: "username: " + og_username )
        expect(sithscorpion.username).to eq(og_username)
          
        visit edit_profile_path
        expect(current_path).to eq(edit_profile_path)
        fill_in "Nome Evocatore", with: new_username
        click_button 'Cerca'
        expect(page).to have_content 'Username già in questo sito. Riprova'
        expect(current_path).to eq(edit_profile_path)

    end
end