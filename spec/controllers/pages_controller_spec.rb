require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "POST #send_friend_request" do
    it "sends a friend request" do
      user2 = create(:user30)
      post :send_friend_request, params: { friend_id: user2.id }
      
      expect(response).to have_http_status(302) #302 è il codice di redirezione
      expect(response).to redirect_to(search_user_path)
      expect(Invitation.last.user_id).to eq(user.id)
      expect(Invitation.last.friend_id).to eq(user2.id)
      expect(Invitation.last.confirmed).to be_falsey
    end
  end

end