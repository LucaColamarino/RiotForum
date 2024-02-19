require 'rails_helper'

RSpec.describe 'Permessi User', type: :system do
    let(:user) { create(:user) }        #non ha l'username
    let(:full_user) { create(:user31) } #ha l'username


    scenario "Registrarsi senza inserire username" do
        sign_up user
        expect(page).to have_content user.email
        expect(page).to have_link 'Log out'
    end

    scenario "Accedere a profilo senza username" do
        sign_up :user
        ex
    end
end