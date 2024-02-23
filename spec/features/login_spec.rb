require 'rails_helper'

RSpec.feature 'Login', type: :feature do
    let(:user) { create(:user30) }  #non ha l'username
   

    scenario "User logins with correct username, email and password" do
        visit new_user_session_path

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password

        click_button "Log in"
        expect(current_path).to eq(root_path)
        expect(find('.profilo')).to have_text(user.email)
        expect(page).to have_content "Logout"
    end

    scenario "User tries to login with incorrect email" do
        visit new_user_session_path

        fill_in "Email", with: 'incorrect_email@com.com'
        fill_in "Password", with: user.password

        click_button "Log in"
        
        expect(current_path).to eq(new_user_session_path)
        expect(page).not_to have_content "Logout"
    
    end

    scenario "User tries to login with incorrect password" do
        visit new_user_session_path

        fill_in "Email", with: user.email
        fill_in "Password", with: 'incorrect_password'

        click_button "Log in"
        
        expect(current_path).to eq(new_user_session_path)
        expect(page).not_to have_content "Logout"
    
    end



end