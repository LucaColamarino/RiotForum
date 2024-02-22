class TeamsController < ApplicationController
  def new
    if current_user.has_team?
      redirect_to root_path
      return
    end
    @team = Team.new
  end

  def create

    @team = Team.new(teams_params)

    @team.lanes = []

    @team.leader_id = current_user.id
    if params[:selected_lanes]
      @team.lanes = params[:selected_lanes]
    end
    unless @team.lanes.include?(params[:leader])
      @team.lanes << params[:leader]  #serve solo per lo show, ma aggiunge un controllo in board
    end
    @team.leader_lane = params[:leader]
    leader_lane = @team.leader_lane
    if !@team.comp[leader_lane].present?
      @team.comp[leader_lane] = @team.leader_id
    end
    @minRank = @team.minRank

    # unless @team.lanes.include?(@leader_lane)
    #   @team.lanes << @leader_lane
    # end

    #@team.comp[@leader_lane] = @team.leader_id

    unless @team.lanes.length > 0 && @team.mode.present? && @minRank.present? && @leader_lane.present? 

      redirect_to teams_new_path
      return
    end

    if @team.save

      current_user.team_id = @team.id
      current_user.save

      @ad = Ad.new
      @ad.team_id = @team.id
      @ad.minRank = @minRank

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
      lead = User.find(@team.leader_id)
      @leader = lead.username
      @leader_lane = @team.leader_lane 
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
        @team.lanes = nil
        @user.save!
      end
    end

    @ad.destroy_all
    @team.destroy

    redirect_to root_path, status: :see_other
  end

  def update

    @team = Team.find(params[:team_id])
    if !@team.comp[params[:position]].present?
    @team.comp[params[:position]] = params[:user_id].to_i
    end

    if @team.save!

      #se params[:user_id] è nil viene gestita come cancellazione di un membro dal team
      if params[:user_id].nil? || params[:user_id].empty?

        @user = User.find(params[:target])
        @user.team_id = nil
        @team.comp.delete(params[:position])

        @team.save
        @user.save

        ad = Ad.find_by(team_id: params[:team_id])
        #se l'ad non esiste ed il team non è pieno, allora l'annuncio viene creato
        if ad.nil? && !team_full? 
          ad = Ad.new
          ad.team_id = params[:team_id]
          ad.minRank = @team.minRank
          ad.save
        end

      #altrimenti il membro con l'id corrispondente viene aggiunto alla lane selezionata
      else
        Request.where(user_id: params[:user_id]).destroy_all

        @user = User.find(params[:user_id])

        #l'utente viene rimosso dal team corrente

        unless @user.team_id.nil?

          old_team = Team.find(@user.team_id)

          old_team.comp.key(@user.id) => old_position
          old_team.comp[old_position] = nil
          old_team.save!
        end

        #ed inserito in quello nuovo
        @user.team_id = @team.id
        if @user.save!

        #rimuove le candidature dei giocatori
        Request.where(user_id: @team.leader_id, team_id: params[:team_id]).destroy_all

          #se il team è pieno l'annuncio correlato viene rimosso
          if team_full?
            ad = Ad.find_by(team_id: params[:team_id])
            ad.destroy
          end
        end
      end
    end
    redirect_back(fallback_location: teams_path)
  end

  private

  def teams_params
    params.require(:team).permit( :mode, :minRank, :leader, lanes: [])
  end

  def team_full?

    counter = 0

    for lane in @team.lanes
      unless @team.comp[lane].nil?
          counter += 1
      end
    end

    counter >= @team.lanes.length
  end

end