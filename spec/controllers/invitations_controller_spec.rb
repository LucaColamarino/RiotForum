require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "PUT #update" do
    it "becomes a friendship" do
        invitation = create(:inv1)
        
        put :update, params: { id: invitation.id }

        expect(invitation.reload.confirmed).to be_truthy
        
        expect(response).to redirect_to(invitations_path)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the friendship" do
        # Test per l'eliminazione di un invito
    end
  end
end