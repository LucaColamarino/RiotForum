class PagesController < ApplicationController

  @game = 'LOL';
  def home
   @game = params[:game];
   @color = @game == "LOL"? "#483D8B" : "#dc3545 ";
    #credo vada usata la sessione per mantenere l'info sul gioco scelto
  end

  def scelta
  end
  def profile
  end

  def board
  end

  def create_team
  end

  def settings
  end

end
