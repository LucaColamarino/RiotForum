require 'rails_helper'

RSpec.describe 'Cancella Notizia', type: :system do
  
  let(:user) {create(:user)}
  before {user.add_role(:moderator)}
  
  before(:each) do
    # Creazione dell'annuncio prima di ogni scenario
    @annuncio = create(:newpost)
  end


  scenario 'Utente non loggato' do
    visit 'news/'+@annuncio.id.to_s
    click_button "delete"
    expect(page).to have_content('Log in')
  end
  scenario 'Moderatore cancella notizia' do
    login_as(user, scope: :user)
    visit 'news/'+@annuncio.id.to_s
    click_button "delete"
    expect(page).to have_content('La notizia è stata cancellata') 
  end
  scenario 'Provare a cancellare notizia da utente loggato senza ruolo mod' do
    user1=create(:user1)
    login_as(user1,scope: :user)
    visit 'news/'+@annuncio.id.to_s
    click_button "delete"
    expect(page).to have_content('You must be admin to create,delete or update a post')
  end
end