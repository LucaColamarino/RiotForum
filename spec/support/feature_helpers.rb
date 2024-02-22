module FeatureHelpers
    def sign_in_and_send_friend_request(sender, receiver)
      sign_in sender
      visit_search_user_page(receiver)
      click_button 'Aggiungi amico'
    end
  
    def visit_search_user_page(user)
      username = URI.encode_www_form_component(user.username)
      #visit "/search_user?search=#{username}&commit=Cerca"
      visit search_user_path(search: username)
    end

    def sign_in_and_accept_friend_request(sender, receiver)
        sign_in receiver
        username = URI.encode_www_form_component(sender.username)  
        visit "/your_notifications"
        friend_request = find('.friend-request', text: sender.username)
        accept_friend_button = within(friend_request) do
            find('.accetta-amicizia') #tasto accetta
        end

        accept_friend_button.click
        
    end

    def sign_in_and_decline_friend_request(sender, receiver)
        sign_in receiver
        username = URI.encode_www_form_component(sender.username)  
        visit "/your_notifications"
        friend_request = find('.friend-request', text: sender.username)
        decline_friend_button = within(friend_request) do
            find('.rifiuta-amicizia') #tasto rifiuta
        end

        decline_friend_button.click
    end
end