require 'rails_helper'

RSpec.describe 'Modifica Notizia', type: :feature do
  
  let(:user) {create(:user)}
  let(:user1) {create(:user)}
  before {user.add_role(:moderator)}
  
  before(:each) do
    # Creazione dell'annuncio prima di ogni scenario
    @annuncio = create(:newpost)
  end


  scenario 'Utente non loggato' do
    visit 'news/'+@annuncio.id.to_s
    click_link "Modifica post"
    expect(page).to have_content('Log in')
  end
  scenario 'Moderatore modifica notizia' do
    login_as(user, scope: :user)
    visit 'news/'+@annuncio.id.to_s
    click_link "Modifica post"
    fill_in 'Title', with: "Prova Modifica" 
    fill_in 'Content', with: "Prova Modifica"
    click_button 'Update Newpost'
    expect(page).to have_content('La notizia è stata modificata') 
  end
  scenario 'Provare a modificare notizia da utente loggato senza ruolo mod' do
    user1=create(:user1)
    login_as(user1,scope: :user)
    visit 'news/'+@annuncio.id.to_s
    click_link "Modifica post"
    expect(page).to have_content('You must be admin to create,delete or update a post')
  end
  scenario 'Modifica post da moderatore cancellando tutti i parametri' do
    login_as(user, scope: :user)
    visit 'news/'+@annuncio.id.to_s
    click_link "Modifica post"
    fill_in 'Title', with: "" 
    fill_in 'Content', with: ""
    click_button 'Update Newpost'
    expect(page).to have_content('La notizia non è stata modificata, parametri non validi')
  end
end