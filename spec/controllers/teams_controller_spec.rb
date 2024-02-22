require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
    describe 'POST #create' do
      let(:user1) { create(:user1) }

      before do
        sign_in user1 
      end

      context 'with valid attributes' do
        it 'creates a new team' do
          expect {
            post :create, params: { team: { mode: 'Normal', minRank: 'Gold', leader_id: user1.id, lanes: ['Top'] } }
          }.to change(Team, :count).by(1)
        end

        it "assigns correctly the leader_id to user1.id" do
          post :create, params: { team: { mode: 'Normal', minRank: 'Gold', leader_id: user1.id, lanes: ['Top'] } }
          expect(assigns(:team).leader_id).to eq(user1.id)
        end
        
        it 'redirects to teams_path' do
          post :create, params: { team: { mode: 'Normal', minRank: 'Gold', leader_id: user1.id, lanes: ['Top'] }}
          expect(response).to redirect_to(teams_path)
        end
      end
    end

    describe 'DELETE #destroy' do 
      let(:user1) {create(:user1)}
      let(:team) {create(:team0)}

      before do
        sign_in user1 
      end


    end
end
  