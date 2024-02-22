require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:user2) { create(:user30) }

  before do
    sign_in user   
  end

  describe "POST #send_friend_request" do
    it "creates a friend request" do
      
      expect {
        post :send_friend_request, params: { user_id: user.id, friend_id: user2.id }
      }.to change(Invitation, :count).by(1)
    end

    it "redirects to the profile of the searched user" do
      post :send_friend_request, params: { user_id: user.id, friend_id: user2.id }
      expect(response).to have_http_status(302) #302 è il codice di redirezione
      expect(response).to redirect_to(search_user_path)
    end

    it "the friend request is not yet confirmed" do
      post :send_friend_request, params: { user_id: user.id, friend_id: user2.id }
      expect(Invitation.last.user_id).to eq(user.id)
      expect(Invitation.last.friend_id).to eq(user2.id)
      expect(Invitation.last.confirmed).to be_falsey
    end
  end

end