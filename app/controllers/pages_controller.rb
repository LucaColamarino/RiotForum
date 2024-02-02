class PagesController < ApplicationController

  @game = 'LOL';   #di default
  def home
    @game = session[:game];
    @color = @game == "LOL"? "#483D8B" : "#dc3545 ";
    #credo vada usata la sessione per mantenere l'info sul gioco scelto
  end

  def scelta
  end

  def profile
    if user_signed_in? && !current_user.username.present?
      redirect_to edit_profile_path
    end
      
  end

  def edit_profile 

    #messo qua in edit_profile per prova, poi penso che andrà usato find_summoner(che fa la API call) e questo solo lo invoca
    if params[:summoner_name].present?
      search_summoner_data = RiotGamesApi.find_summoner(params[:summoner_name])
      case search_summoner_data[:code]
      when 200

        @summoner_data = search_summoner_data[:body]

        @summoner_name = @summoner_data["name"]
        @summoner_level = @summoner_data["summonerLevel"]

        render 'profile'

      when 404 #questi ancora non funzionano.L'idea è notificare dell'errore e ridargli la stessa pag con la barra di ricerca per contiuare
        
        flash[:error] = 'Evocatore non trovato. Please enter another summoner name.'
        redirect_to edit_profile_path

      else
        
        flash.alert = 'Errore. Riprova tra qualche minuto'
        redirect_to root_path

      end
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

  def find_summoner
  end

end
