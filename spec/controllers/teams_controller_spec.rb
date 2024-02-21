require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
    describe "POST #create" do
      let(:user) { create(:user30) }
  
      before do
        sign_in user
      end
  
      context "with valid parameters" do
        let(:team_params) { lanes = { mode: "Normal", minRank: "Diamond" } }
  
        it "creates a new team" do
          expect {
            post :create, params: { team: team_params }
          }.to change(Team, :count).by(1)
        end
  
        it "assigns the leader_id correctly" do
          post :create, params: { team: team_params }
          expect(assigns(:team).leader_id).to eq(user.id)
        end
  
        # Add more expectations as needed
      end
  
      context "with invalid parameters" do
        let(:invalid_team_params) { { mode: "casual" } } # Missing minRank
  
        it "does not create a new team" do
          expect {
            post :create, params: { team: invalid_team_params }
          }.to_not change(Team, :count)
        end
  
        it "redirects to teams_new_path" do
          post :create, params: { team: invalid_team_params }
          expect(response).to redirect_to(teams_new_path)
        end
  
        # Add more expectations as needed
      end
    end
  end
  