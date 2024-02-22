require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:user) { create(:user) }
    let(:user1) { create(:user1) }

    let(:valid_params) do
        {
        team: {
            mode: 'Normal',
            minRank: 'Silver',
            leader_lane: 'Top',
            lanes: ['Top', 'Mid']
        }
        }
    end

    let(:invalid_params) do
        {
        team: {
            mode: 'Normal',
            minRank: 'Silver',
            leader_lane: nil,
            lanes: ['Top', 'Mid']
        }
        }
    end

    let(:new_request_params) do
        {
        request: {
            position: 'Mid',
            user_id: user1.id,
            team_id: nil
        }
        }
    end

    describe "POST #create" do
        context 'with valid parameters' do

            before do
                sign_in(user)
                post :create, params: valid_params
            end

            it 'creates a new team' do
                expect(Team.count).to eq(1)
            end

            it 'redirects to teams_path' do
                expect(response).to redirect_to(teams_path)
            end

            it 'sets the current user\'s team_id' do
                expect(user.reload.team_id).to eq(Team.last.id)
            end

            it 'sets the leader to the selected position' do
                expect(Team.find(user.reload.team_id).comp[valid_params[:team][:leader_lane]]). to eq(user.id)
            end

            it 'creates a new ad' do
                expect(Ad.count).to eq(1)
            end

            it 'sets the ad\'s team_id correctly' do
                expect(Ad.last.team_id).to eq(Team.last.id)
            end

            it 'sets the ad\'s minRank correctly' do
                expect(Ad.last.minRank).to eq('Silver')
            end
        end
        context 'with_invalid_parameters' do

            before do
                sign_in(user)
                post :create, params: invalid_params
            end
    
            it 'does not create a new team' do
                expect(Team.count).to eq(0)
            end
    
            it 'does not create a new ad' do
                expect(Ad.count).to eq(0)
            end
    
            it 'redirects to teams_new_path' do
                expect(response).to redirect_to(teams_new_path)
            end
        end
        
    end

    describe "GET #show" do

        before do
            sign_in(user)
            post :create, params: valid_params
            
        end

        it 'shows the current user\'s team' do
            get :show
            #se il codice http != 3xx non c'è stato reindirizzamento
            expect(response).not_to have_http_status(:redirect)
        end

        it 'redirects if the user has no team' do
            sign_out(user)
            sign_in(user1)
            get :show
            expect(response).to redirect_to(root_path)
        end

    end

    describe "PATCH #update" do

        before do
        
            sign_in(user)
            post :create, params: valid_params
            sign_out(user)

            sign_in(user1)
            new_request_params[:request][:team_id] = Team.last.id
            new_request = Request.create(new_request_params[:request])

            sign_out(user1)

            sign_in(user)

            patch :update, params: {
                    id: Team.last.id,
                    team_id: Team.last.id,
                    user_id: user1.id,
                    position: new_request.position,
                }

        end

        it 'accepts a user into the team' do

            expect(user1.reload.team_id).not_to be_nil
        end

        it 'kicks a user from the team' do

            Team.last.comp.key(user1.id) => position

            patch :update, params: {
                    id: Team.last.id,
                    team_id: Team.last.id,
                    user_id: nil,
                    position: position,
                    target: user1.id
                }

            expect(user1.reload.team_id).to be_nil
        end

    end

    describe "DELETE #destroy" do

        before do
        
            sign_in(user)
            post :create, params: valid_params
            delete :destroy
        end

        it 'deletes the team' do

            expect(Team.count).to eq(0)
        end

        it 'redirects to home' do

            expect(response).to redirect_to(root_path)
        end
    end

end