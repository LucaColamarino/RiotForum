require 'rails_helper'

RSpec.describe 'Crea Notizia', type: :system do
  let(:user) {create(:user)}
  before {user.add_role(:moderator)}


  scenario 'Utente non loggato' do
    visit 'news/newpost' 
    expect(page).to have_content('Log in')
  end
  scenario 'Moderatore inserisce post senza titolo e contenuto' do
    login_as(user, scope: :user)
    visit 'news/newpost'
    fill_in 'Title', with: ''
    fill_in 'Content', with: ''
    click_button "Create Newpost"
    expect(page).to have_content('Parametri vuoti non sono accettati') 
  end

  scenario 'Moderatore inserisce post con titolo ma senza contenuto' do
    login_as(user, scope: :user)
    visit 'news/newpost'
    fill_in 'Title', with: 'AAA'
    fill_in 'Content', with: ''
    click_button "Create Newpost"
    expect(page).to have_content('Parametri vuoti non sono accettati') 
  end
  scenario 'Moderatore inserisce post senza titolo ma con contenuto' do 
    login_as(user, scope: :user)
    visit 'news/newpost'
    fill_in 'Title', with: ''
    fill_in 'Content', with: 'AAA'
    click_button "Create Newpost"
    expect(page).to have_content('Parametri vuoti non sono accettati')
  end
  scenario 'Provare a creare notizia da utente loggato senza ruolo mod' do
    user1=create(:user1)
    login_as(user1,scope: :user)
    visit 'news/newpost'
    expect(page).to have_content('You must be admin to create,delete or update a post')
  end
end