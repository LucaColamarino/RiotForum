class TeamsController < ApplicationController
    def new
      @team = Team.new
    end

    def create
      @team = Team.new(teams_params)
      @team.leader_id = current_user.id
      @team.lanes = params[:team][:lanes] || {}

      @leader_lane = params[:team][:leader_lane]

      unless @team.lanes.include?(@leader_lane)

        @team.lanes << @leader_lane
      end

      @team.comp[@leader_lane] = @team.leader_id

      if @team.save

        current_user.team_id = @team.id
        current_user.save

        redirect_to teams_path

      else
        redirect_to teams_new_path

      end

    end

    def show
      @team = Team.find(current_user.team_id)

    end

    def destroy

      @team = Team.find(current_user.team_id)
      current_user.team_id = nil

      current_user.save
      @team.delete

      redirect_to home_path, status: :see_other
    end

    private

    def teams_params

      params.require(:team).permit(:mode, lanes: [])
    end

    protected 

end