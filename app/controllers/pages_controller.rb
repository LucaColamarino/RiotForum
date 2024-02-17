class PagesController < ApplicationController

  @game = 'LOL';   #di default
  
  def home
    @game = session[:game];
    @color = @game == "LOL"? "#483D8B" : "#dc3545 ";
    
    url = URI.parse('https://euw1.api.riotgames.com/lol/platform/v3/champion-rotations');
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true if url.scheme == 'https'

    request = Net::HTTP::Get.new(url)
    request['X-Riot-Token'] = ENV['RIOT_API_KEY']

    @rotation_champs = JSON.parse(http.request(request).body)['freeChampionIds']

    @annunci_home = Ad.order(updated_at: :desc).limit(4)
  end

  def scelta
  end

#------------------------------------
  def search_player
    if params[:summonerName].present?
      search_summoner_data = self.find_summoner(params[:summonerName])

      if search_summoner_data[:code] == 200
        @summoner = search_summoner_data[:body]

        @summoner_name = @summoner["name"]
        @summoner_level = @summoner["summonerLevel"]
        @summonerID = @summoner["id"]
        @iconID = @summoner["profileIconId"]
        @puuid = @summoner["puuid"]

        @stats = self.getPlayerStats(@summonerID)
          if @stats[:code] == 200
              for queue in @stats[:body] do
                @stats_data = @stats[:body][queue]
                if !@stats_data.nil?
                  @queueType = @stats_data["queueType"]
                  @tier = @stats_data["tier"]
                  @rank = @stats_data["rank"]
                  @wins = @stats_data["wins"]
                  @losses = @stats_data["losses"]
                end
              end
          end
      end
      #-------------------------------#
      summoner_matchlist = RiotGamesApi.getMatchList(@puuid)
      if summoner_matchlist[:code] == 200
        @matchlist = summoner_matchlist[:body]
      else
        flash[:alert] = 'Error in loading match history'
      end
      #-------------------------------#
      @length = @matchlist.length
      
      @matchData = Array.new(@length)
      @durata = Array.new(@length)
      @gameMode = Array.new(@length)
      @participants = Array.new(@length)
      @players = Array.new(@length)
      @searchedPlayer = Array.new(@length)
      @searchedPlayer_data = Array.new(@length)
      for i in 0...@length do
        @matchData[i] = self.getMatch(@matchlist[i])
        if @matchData[i] != "error"  #cioè matchData=response.body
          
          #-----INFO GAME

          @durata[i] = formattedTime(@matchData[i]["info"]["gameDuration"])
          @gameMode[i] = @matchData[i]["info"]["gameMode"]

          #-----INFO SINGOLI GIOCATORI

          @players[i] = {}
          @searchedPlayer_data[i] = {}
          @participants[i] = @matchData[i]["info"]["participants"]  #player del singolo game
          for j in 0...10 do #10 numero players
            @players[i][j] = {
              puuid: @participants[i][j]["puuid"],
              champion: @participants[i][j]["championName"],
              kills: @participants[i][j]["kills"],
              deaths: @participants[i][j]["deaths"],
              assists: @participants[i][j]["assists"],
              win: @participants[i][j]["win"], #true/false
              lane: @participants[i][j]["lane"],
              cs: @participants[i][j]["totalMinionsKilled"] + @participants[i][j]["neutralMinionsKilled"],
              team: @participants[i][j]["teamId"],
              summonerName: @participants[i][j]["summonerName"]
            }

            if @players[i][j][:puuid] == @puuid
              @searchedPlayer[i] = j
              @searchedPlayer_data[i] = {}
              for n_item in 0..6 do
                @searchedPlayer_data[i]["item#{n_item}"] = @participants[i][j]["item#{n_item}"]
              end
              @searchedPlayer_data[i]["gold"] = @participants[i][j]["goldEarned"]
              
            end
          end
        else
          flash[:alert] = 'Error in loading match history'
        end
      end

    else
      redirect_to home_path
    end
  end
#---------------------------------------------------
  def search_user
    @search_query = params[:search]
    @found_user = User.find_by(username: @search_query)
    if @found_user
      user_info_data = self.find_summoner(@search_query)
      if user_info_data[:code] == 200
        @user_data = user_info_data[:body]
        @user_icon = @user_data["profileIconId"]
        @user_lvl = @user_data["summonerLevel"]
        @user_id = @user_data["id"]
      end
      
      @stats = self.getPlayerStats(@user_id)
      if @stats[:code] == 200
        @stats_data = @stats[:body]
        #queueType
        #tier
        #rank
        #wins
        #losses
      end

    else
      flash[:alert] = "Utente '#{@search_query}' non trovato."
      redirect_to profile_path
    end
  end
#---------------------------------------------------

  def profile
    if user_signed_in?

      if flash[:alert]
        # per triggerare il messaggio d'errore di cerca utente sito inesistente
        flash.now[:error] = flash[:error]
      end
      
      if current_user.username.present?
        
        data = self.find_summoner(current_user.username)
        if data[:code] == 200
          @summoner = data[:body]

          @your_summonerName = @summoner["name"]
          @your_summonerLevel = @summoner["summonerLevel"]
          @your_summonerID = @summoner["id"]
          @your_icon= @summoner["profileIconId"]
          @puuid = @summoner["puuid"]

        end

        #configura lista amici
        @friendships_sent = Invitation.where(confirmed: true).where(user_id: current_user.id)
        @friendships_received = Invitation.where(confirmed: true).where(friend_id: current_user.id)

      else
        redirect_to edit_profile_path #aggiorna solo l'username
      end
    else
      redirect_to sign_up_path #?
    end
    
  end
  
  #--------------------------------
  def edit_profile 
    if request.get? && !params[:inputType].present?
      # Affinchè non mi dia errore quando apro la pagina per la prima volta
      return
    end

    if !params[:username].nil?     
       updateBy_username(params[:username]) 
    end

  end

  def updateBy_username(username)
    if username_valid?(username)
      current_user.update(username: username)
      redirect_to profile_path(user: username)
    else
      flash.now[:error] = "Username inesistente. Riprova"
      render :edit_profile
    end
  end

  #ancora da implementare
  def updateBy_riotId(name,tag)
    if riotID_valid?(name,tag)  #non è stato (ancora) messo come colonna in user
      data = self.find_byRiotId(name,tag)
      if data[:code]==200
        data_puuid = self.find_byPuuid(data[:body][:puuid])
        if data_puuid[:code] = 200
          redirect_to profile_path(user: data_puuid[:body]["name"])
        end
      end
    else
      flash.now[:error] = "RiotID inesistente. Riprova"
      render :edit_profile
    end
  end

  def posta
  end

  def your_notifications
    @friend_requests = Invitation.where(friend_id: current_user.id, confirmed: false)
    render partial: 'your_notifications'
  end

  def your_messages
    render partial: 'your_messages'
  end
  
  #--------------------------------
  def board
    @game = params[:game];

    @annunci = Ad.order(updated_at: :desc).all

  end


  def create_team
  end

  def team
  end

  def settings
  end
  
  def send_friend_request
    friend = User.find_by(id: params[:friend_id])
    if friend
      @invitation = Invitation.create(user_id: current_user.id, friend_id: friend.id)
      if @invitation.save
        flash[:notice] = "Inviata richiesta a #{friend.username}"
        redirect_to search_user_path
      else
        if @invitation.errors[:user_id].include?("has already been taken")
          # Handle duplicate invitation error
          flash[:alert] = "You already sent an invitation to this friend."
          redirect_to search_user_path
        else
          flash[:alert] = "Failed to send invitation."
          redirect_to search_user_path
        end
        # Redirect or render appropriate response
      end
    end
  end

  def destroy_friendship
    invitation = Invitation.find_by(friend_id: params[:friend_id])

    if invitation
      invitation.destroy
      flash[:notice] = "Invitation successfully removed"
      redirect_to profile_path
    else
      redirect_to home_path
    end
  end

  #----------------- API & PRIVATE METHODS ---------------#
  private 

  def find_summoner(summoner)
    return RiotGamesApi.find_summoner(summoner)
  end

  def find_byRiotId(name, tag)
    return RiotGamesApi.find_byRiotId(name, tag)
  end

  def find_byPuuid(puuid)
    return RiotGamesApi.find_byPuuid(puuid)
  end

  def getMatch(matchId)
    match = RiotGamesApi.getMatch(matchId)
    if match[:code] == 200
      return match[:body]
    else
      return "error"
    end
  end

  def getPlayerStats(summonerID)
    return RiotGamesApi.getPlayerStats(summonerID)
  end

  def formattedTime(all_seconds)
    hours = all_seconds / 3600
    minutes = all_seconds / 60
    seconds = all_seconds - (hours*3600) - (minutes*60)
    return "#{hours}:#{minutes}:#{seconds}"
  end

  def username_valid?(username)
    summoner = self.find_summoner(username)
    if summoner[:code] == 200
      summoner_name = summoner[:body]["name"]
      return summoner_name == username
    end
  end

  def riotID_valid?(name,tag)
    riotUser = self.find_byRiotId(name,tag)
    if riotUser[:code] == 200
      gameName = riotUser[:body]["gameName"]
      tagline = riotUser[:body]["tagLine"]
      return name == gameName && tag == tagline
    end
  end


end