require 'rails_helper'

RSpec.describe 'Crea Notizia', type: :system do
  scenario 'Utente non loggato' do
    visit 'news/newpost' 
    expect(page).to have_content('Log in')
  end

 # scenario 'Moderatore inserisce post senza titolo e contenuto' do
 #   visit 'news/newpost'
 #   fill_in 'Title', with: ''
 #   fill_in 'Content', with: ''
 #   expect(page).to have_content('Parametri vuoti non sono accettati')
 # end
    
end