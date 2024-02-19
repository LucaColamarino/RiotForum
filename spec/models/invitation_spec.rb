require 'rails_helper'


RSpec.feature "Friendship", type: :feature do
    let(:richiedente) { create(:user30) }
    let(:accettante) { create(:user31) }
  
    #INVIO RICHIESTA AMICIZIA
    scenario "User1 sends a friend request to User2" do
        sign_in richiedente
        username = URI.encode_www_form_component(accettante.username)
        visit "/search_user?search=#{username}&commit=Cerca"
        click_button 'Aggiungi amico'
        expect(page).to have_content "Inviata richiesta a #{accettante.username}"
    end

    #ACCETTA RICHIESTA
    scenario "User2 accepts the friend request from User1" do
        sign_in richiedente #tizio che manda
        username = URI.encode_www_form_component(accettante.username)
        visit "/search_user?search=#{username}&commit=Cerca"
        click_button 'Aggiungi amico'
        click_button 'Logout'
        

        sign_in accettante  #tizio che deve accettare
        username = URI.encode_www_form_component(richiedente.username)  
        visit "/your_notifications"
        friend_request = find('.friend-request', text: richiedente.username)
        accept_friend_button = within(friend_request) do
            find('.accetta-amicizia')
        end

        accept_friend_button.click
        visit "/profile"
        expect(page).to have_selector('.friend', text: richiedente.username)
    end
    
    #FLOW COMPLETO DI RICHIESTA ED ACCETTAZIONE AMICIZIA
    scenario "User1 sends request to User2 and finds User2 in the friend list after the request is accepted" do
        sign_in richiedente #tizio che manda
        username = URI.encode_www_form_component(accettante.username)
        visit search_user_path(search: username)
        click_button 'Aggiungi amico'
        click_button 'Logout'
        
        invitation = Invitation.find_by(user_id:richiedente.id,friend_id:accettante.id)
        expect(invitation.confirmed).to be_falsey

        sign_in accettante  #tizio che deve accettare
        username2 = URI.encode_www_form_component(richiedente.username)  
        visit "/your_notifications"
        friend_request = find('.friend-request', text: username2)
        accept_friend_button = within(friend_request) do
            find('.accetta-amicizia')
        end
        accept_friend_button.click
        invitation.reload
        expect(invitation.confirmed).to be_truthy
        expect(page).to have_no_content(friend_request)

        visit posta_path
        click_button 'Logout'

        sign_in richiedente
        visit "/profile"
        expect(page).to have_selector('.friend', text: accettante.username)
    end

    #FLOW COMPLETO DI RICHIESTA E RIFIUTO AMICIZIA
    scenario "User1 sends request to User2, but doesn't find User2 in the friendlist since the request is declined" do
        sign_in richiedente #tizio che manda
        username = URI.encode_www_form_component(accettante.username)
        visit search_user_path(search: username)
        click_button 'Aggiungi amico'
        click_button 'Logout'
        
        invitation = Invitation.find_by(user_id:richiedente.id,friend_id:accettante.id)
        
        expect(invitation.confirmed).to be_falsey

        sign_in accettante  #tizio che deve accettare
        username2 = URI.encode_www_form_component(richiedente.username)  
        visit "/your_notifications"
        friend_request = find('.friend-request', text: username2)
        decline_friend_button = within(friend_request) do
            find('.rifiuta-amicizia') #tasto rifiuta
        end
        decline_friend_button.click
        expect {
            Invitation.find(invitation.id)
        }.to raise_error(ActiveRecord::RecordNotFound)
        expect(page).to have_no_selector('.friend-request', text: username2)
        #expect(page).to have_no_content(friend_request)

        visit posta_path
        click_button 'Logout'

        sign_in richiedente
        visit "/profile"
        expect(page).not_to have_selector('.friend', text: accettante.username)
    end

end
  