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

      @ad = Ad.new
      @ad.team_id = @team.id
      @ad.minRank = params[:team][:minRank]

      if@ad.save

        redirect_to teams_path
      else

        redirect_to teams_new_path
        @team.destroy
      end
    else

      redirect_to teams_new_path
    end
  end

  def show
    if !current_user.team_id.nil?

      @team = Team.find(current_user.team_id)
    else

      redirect_to root_path
    end
  end

  def destroy

    @team = Team.find(current_user.team_id)
    @ad = Ad.where(team_id: @team.id)

    for lane in Forum::LANES do
      unless @team.comp[lane].nil?

        @user = User.find(@team.comp[lane])
        @user.team_id = nil
        @team.comp[lane] = nil
        @user.save
      end
    end

    @ad.destroy_all
    @team.destroy

    redirect_to root_path, status: :see_other
  end

  def update

    @team = Team.find(params[:team_id])
    @team.comp[params[:position]] = params[:user_id]
    if @team.save
      
      unless params[:user_id].nil?

        Request.find_by(user_id: params[:user_id]).destroy
      end

      @user = User.find(params[:user_id])
      @user.team_id = params[:team_id]
      if @user.save
        
        redirect_to profile_path

        for lane in @team.lanes
          unless @team.comp[lane].nil?
              counter += 1
          end
        end

        counter >= lanes.length

        if @team.is_full?
          Request.where(user_id: params[:user_id], team_id: params[:team_id]).destroy_all
        end
      end
    end
    redirect_to root_path
  end

  private

  def teams_params

    params.require(:team).permit(:mode, lanes: [])
  end
end