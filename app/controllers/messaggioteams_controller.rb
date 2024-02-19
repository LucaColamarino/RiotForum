class MessaggioteamsController < ActionController::Base
    layout 'application'
    before_action :authenticate_user!


    def show
        params[:team_id]=params[:team_id]
        @messageteam=Messaggioteam.find_by(params[:team_id])
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
            redirect_to '/teams'
        end
    end

    def edit
        @messageteam = Messaggioteam.find_by(params[:team_id])
        # Verifica se il messaggio appartiene all'utente corrente
    end

    def update
        @messageteam = Messaggioteam.find_by(params[:team_id])
        # Verifica se il messaggio appartiene all'utente corrente
      
        # Aggiorna il messaggio esistente aggiungendo del testo aggiuntivo
        additional_text = params[:additional_text].strip
        if additional_text.present?
          @messageteam.text += "\n#{additional_text}"+"   "+current_user.username+"\n"
          @messageteam.save
        end
      
        redirect_to '/teams', notice: "Aggiunte salvate con successo."
      end






    private

    def messaggio_params
        params.require(:messaggioteam).permit(:text)
    end


end