require 'rails_helper'

RSpec.feature 'Registration', type: :feature do
    let(:user) { build(:user30) }        #non ha l'username
    let(:user1) { create(:user1) }  #registrato nel sito
   

    scenario "User registers with correct username, email and password" do
        visit new_user_registration_path

        fill_in "Nome Evocatore", with: user.username
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password

        click_button "Registrati"
        expect(current_path).to eq(root_path)
        expect(find('.profilo')).to have_text(user.email)
    end

    scenario "User registers with invalid email" do
        visit new_user_registration_path

        fill_in "Nome Evocatore", with: user.username
        fill_in "Email", with: 'invalid_email'
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password

        click_button "Registrati"
        
        expect(page).to have_content('Email is invalid')
    end

    scenario "User registers without username and is redirected to edit_profile" do
        visit new_user_registration_path

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password

        click_button "Registrati"
        expect(current_path).to eq(edit_profile_path)
        fill_in "Nome Evocatore", with: user.username
        click_button 'Cerca'
        expect(current_path).to eq(profile_path)
        expect(page).to have_content 'username: '+user.username
    end

    scenario "User registers with an already existing email" do
        visit new_user_registration_path

        fill_in "Nome Evocatore", with: user.username
        fill_in "Email", with: user1.email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password

        click_button "Registrati"
        
        expect(page).to have_content('Email has already been taken')
        expect(page).not_to have_content "Logout"
    end

end