require 'rails_helper'

RSpec.describe Invitation, type: :model do

  describe "POST #create" do
    it "creates a friend request" do
      user1 = create(:user)
      user2 = create(:user1)
      
      invitation = Invitation.create(user_id: user1.id, friend_id: user2.id)
      
      expect(invitation.user_id).to eq(user1.id)
      expect(invitation.friend_id).to eq(user2.id)
      expect(invitation.confirmed).to be_falsey
    end
  end

end
