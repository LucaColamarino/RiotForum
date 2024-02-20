RSpec.configure do |config|
    config.include Devise::Test::IntegrationHelpers, type: :feature
    config.include Devise::Test::IntegrationHelpers, type: :controller
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
        fill_in 'Password confirmation', with: user.password
        click_button 'Registrati'
    end

    def sign_up_full(user)
        visit 'users/sign_up'
        fill_in 'Nome Evocatore', with: user.username
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
        click_button 'Registrati'
    end
end