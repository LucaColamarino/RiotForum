require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user30) }
  let(:user1) {create(:user1)}

  before(:each) do
    @invitation = create(:invitation30, user_id: user.id, friend_id: user1.id)
  end

  describe "PUT #update" do
    it "becomes a friendship" do

        put :update, params: { id: @invitation.id }

        expect(@invitation.reload.confirmed).to be_truthy
        
        expect(response).to redirect_to(request.referer)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the friendship" do
        
      put :destroy, params: { id: @invitation.id }
      expect {
            Invitation.find(@invitation.id)
        }.to raise_error(ActiveRecord::RecordNotFound)

        expect(response).to redirect_to(request.referer)
      
    end
  end
end