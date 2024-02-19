class RequestsController < ApplicationController
    def new
        @request = Request.find()
    end
    def create
        @request = Request.new()
        @request.position = params[:request][:leader_lane]
        @request.team_id = params[:request][:team_id]
        @request.user_id = params[:request][:user_id]

        @request.save

        redirect_to board_path

    end

    def show

    end

    def destroy

        @request = Request.find(params[:id])
        @request.destroy

        redirect_to profile_path, status: :see_other
    end

    private

    def request_params

        params.require(:request).permit(:leader_lane, :team_id, :user_id)
    end
end