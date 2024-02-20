class MessaggioteamsController < ActionController::Base
    layout 'application'
    before_action :authenticate_user!


    def show
        team_exists = Team.exists?(params[:team_id])
        if team_exists
         @team=Team.find(params[:team_id])
         if(current_user.id == @team.leader_id)||(@team.comp.has_value?(current_user.id)) 
           @messageteam=Messaggioteam.find_by(team_id: (params[:team_id]))
         else
            flash[:alert]= "Non fai parte del team per accedere alla chat"
            redirect_to "/profile"
         end
        else
            flash[:alert]='Non esiste il team'
            redirect_to "/profile" 
        end
    end
    def new
        params[:team_id] = params[:team_id]
        @messageteam=Messaggioteam.new
    end


    def create
        @messageteam=Messaggioteam.new(messaggio_params)
        @messageteam.team_id=params[:team_id]
        @messageteam.text += " - #{current_user.username}"

        if @messageteam.save
            redirect_to request.fullpath
        end
    end

    def edit
        team_exists = Team.exists?(params[:team_id])
        if team_exists
         @team=Team.find(params[:team_id])
         if(current_user.id == @team.leader_id)||(@team.comp.has_value?(current_user.id)) 
           @messageteam = Messaggioteam.find_by(team_id: (params[:team_id]))
         else
            flash[:alert]= "Non fai parte del team per accedere alla chat"
            redirect_to "/profile"
         end
        else
            flash[:alert]="Non esiste il team"
            redirect_to "/profile"
        end
        # Verifica se il messaggio appartiene all'utente corrente
    end

    def update
        @messageteam = Messaggioteam.find_by(team_id: (params[:team_id]))
        # Verifica se il messaggio appartiene all'utente corrente
      
        # Aggiorna il messaggio esistente aggiungendo del testo aggiuntivo
        additional_text = params[:additional_text].strip
        if additional_text.present?
          @messageteam.text += "\n #{additional_text}"+" - "+current_user.username+"\n"
          @messageteam.save
        end
      
        redirect_to '/teams/messaggioteams/:team_id'
    end

    def destroy
        @messageteam = Message.find_by(team_id: (params[:team_id])).delete
        flash[:alert]="Chat cancellata con successo"
        redirect_to '/teams'
    end






    private

    def messaggio_params
        params.require(:messaggioteam).permit(:text)
    end


end