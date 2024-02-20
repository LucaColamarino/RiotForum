require 'rails_helper'

RSpec.describe 'Crea Messaggio', type: :feature do
  let(:user) {create(:user)}
  let(:user1) {create(:user)}

  
#  before(:each) do
    # Creazione del messaggio prima di ogni scenario
 #   @messaggio = create(:message)
 # end


  scenario 'Utente cancella messaggio' do
    user1=create(:user1)
    user=create(:user)
    login_as(user, scope: :user)
    @messaggio = create(:message)


    visit 'messages/'+@messaggio.id.to_s


    click_button "delete"
    expect(page).to have_content('Messaggio cancellato con successo') 
  end
end