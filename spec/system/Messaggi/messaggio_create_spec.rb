require 'rails_helper'

RSpec.describe 'Crea Messaggio', type: :system do
  let(:user) {create(:user)}
  #before {user.add_role(:moderator)}


  scenario 'Utente non loggato entra nei messaggi' do
    visit '/messages/' 
    expect(page).to have_content('Log in')
  end
  scenario 'Utente crea messaggio' do
    login_as(user, scope: :user)
    user1=create(:user1)
    visit 'messages/new'
    fill_in 'A', with: 'user1@example.com'
    fill_in 'Oggetto', with: 'Questo è un test'
    fill_in 'Messaggio', with: 'Questo è un test'
    click_button "Invia"
    expect(page).to have_content('Il messaggio è stato inviato') 
  end

  scenario 'Utente crea messaggio senza email o email sbagliata' do
    login_as(user, scope: :user)
    user1=create(:user1)
    visit 'messages/new'
    fill_in 'A', with: ''
    fill_in 'Oggetto', with: ''
    fill_in 'Messaggio', with: ''
    click_button "Invia"
    expect(page).to have_content('Il destinatario non esiste o hai sbagliato ad inserire l email') 
  end
 scenario 'Utente crea messaggio senza Soggetto' do 
    login_as(user, scope: :user)
    user1=create(:user1)
    visit 'messages/new'
    fill_in 'A', with: 'user1@example.com'
    fill_in 'Oggetto', with: ''
    fill_in 'Messaggio', with: 'AAA'
    click_button "Invia"
    expect(page).to have_content('Inserire un titolo e un contenuto valido')
  end
  scenario 'Utente crea messaggio senza Contenuto' do
    login_as(user,scope: :user)
    user1=create(:user1)
    visit 'messages/new'
    fill_in 'A', with: 'user1@example.com'
    fill_in 'Oggetto', with: 'AAA'
    fill_in 'Messaggio', with: ''
    click_button "Invia"
    expect(page).to have_content('Inserire un titolo e un contenuto valido')
  end

end