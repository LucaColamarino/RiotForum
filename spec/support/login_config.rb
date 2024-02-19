RSpec.configure do |config|
    config.include Devise::Test::IntegrationHelpers, type: :system

    def sign_in(user)
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
    end

    def sign_up(user)
        visit 'users/sign_up'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password_confirmation', with: user.password
        
    end

    def sign_up_full(user)
        visit new_registration_path
        fill_in :username, with: user.username
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password_confirmation', with: user.password
        click_button 'Registrati'
    end
end