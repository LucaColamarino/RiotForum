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
  end

  def scelta
  end

  def search_player
    if params[:summonerName].present?
      search_summoner_data = self.find_summoner(params[:summonerName])

      if search_summoner_data[:code] == 200
        @summoner = search_summoner_data[:body]

        @summoner_name = @summoner["name"]
        @summoner_level = @summoner["summonerLevel"]
        @iconID = @summoner["profileIconId"]
        @puuid = @summoner["puuid"]

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
      for i in 0...@length do
        @matchData[i] = self.getMatch(@matchlist[i])
        if @matchData[i] != "error"  #cioè matchData=response.body
          
          #-----INFO GAME

          @durata[i] = formattedTime(@matchData[i]["info"]["gameDuration"])
          @gameMode[i] = @matchData[i]["info"]["gameMode"]

          #-----INFO SINGOLI GIOCATORI

          @players[i] = {}
          
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

  def profile
    if user_signed_in?
      if current_user.username.present?
        
        your_data = self.find_summoner(current_user.username)
        if your_data[:code] == 200
          @your_summoner = your_data[:body]

          @your_summonerName = @your_summoner["name"]
          @your_summonerLevel = @your_summoner["summonerLevel"]
          @your_summonerID = @your_summoner["id"]
          @your_icon= @your_summoner["profileIconId"]
          @your_puuid = @your_summoner["puuid"]
        end

        @your_stats = self.getPlayerStats(@your_summonerID)
        if @your_stats != "error"
          if @your_stats.empty?
            @inactive = true
          else
            @inactive = false
=begin
            @queueType = @your_stats["queueType"]
            @tier = @your_stats["tier"]
            @rank = @your_stats["rank"]
            @wins = @your_stats["wins"]
            @losses = @your_stats["losses"]
=end
          end
          
        end

      else
        redirect_to edit_profile_path #aggiorna solo l'username
      end
    else
      redirect_to sign_up_path #?
    end

=begin
    if user_signed_in? && current_user.username.present?
      @username_on = true
      search_summoner_data = self.find_summoner(current_user.username)

      if search_summoner_data[:code] == 200
        @your_summoner = search_summoner_data[:body]

        @your_summoner_name = @your_summoner["name"]
        @your_summoner_level = @your_summoner["summonerLevel"]
        @iconID = @your_summoner["profileIconId"]
        @puuid = @your_summoner["puuid"]

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
      @you = Array.new(@length)
      @allies = Array.new(@length)
      for i in 0...@length do
        @matchData[i] = self.getMatch(@matchlist[i])
        if @matchData[i] != "error"  #cioè matchData=response.body
          
          #-----INFO GAME

          @durata[i] = formattedTime(@matchData[i]["info"]["gameDuration"])
          @gameMode[i] = @matchData[i]["info"]["gameMode"]

          #-----INFO SINGOLI GIOCATORI

          @players[i] = {}
          
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
              @you[i] = j
            end

          end



        else
          flash[:alert] = 'Error in loading match history'
        end
      end

    else
      @username_on = false
      redirect_to edit_profile_path

    end
=end      
  end

  def edit_profile 
    #messo qua in edit_profile per prova, poi penso che andrà usato find_summoner(giù)che fa la API call e questo solo lo invoca
    
    if params['summoner_name'].present?
      params['summoner_name'] = "ayo"
      render 'profile'
    end
  end

  def board
    @game = params[:game];
  end

  def create_team
  end

  def your_team
  end

  def settings
  end
  
  def news
    @game = params[:game];
  end


  #----------------- API METHODS ---------------#

  def find_summoner(summoner)
    return RiotGamesApi.find_summoner(summoner)
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
    stats = RiotGamesApi.getPlayerStats(summonerID)
    return stats[:body]
  end

  def formattedTime(all_seconds)
    hours = all_seconds / 3600
    minutes = all_seconds / 60
    seconds = all_seconds - (hours*3600) - (minutes*60)
    return "#{hours}:#{minutes}:#{seconds}"
  end

end