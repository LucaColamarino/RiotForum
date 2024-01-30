class PagesController < ApplicationController
<<<<<<< HEAD
  
  @game = "LOL"; #per ora lo lascio come default, ma non va bene

  def scelta
  end
=======

>>>>>>> 59817eccb985728f6489cd62254de3c4805170c5

  def home
   @game = params[:game];
   @color = @game == "LOL"? "#483D8B" : "#dc3545 ";
    #credo vada usata la sessione per mantenere l'info sul gioco scelto
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
