class MessagesController < ActionController::Base
    layout 'application'
    before_action :authenticate_user!

    def index
        @messages=Message.where(receiver_id: current_user.id)
    end


    def show
        @message=Message.find(params[:id])
        if @message.receiver_id != current_user.id
            redirect_to profile_path
        end
              
    end

    def new
        @message=Message.new
    end
#receive email sarà da cambiare con username forse RICORDA
    def create
        receiver = User.find_by(email: params_msg[:receive_email])
        if receiver.nil?
            flash[:alert]='Il destinatario non esiste o hai sbagliato ad inserire l email'
            redirect_to '/profile'
            return
        end

        @message= Message.new(params_msg)
        @message.sender_id = current_user.id
        @message.receiver_id = receiver.id

        if (@message.subject=='')||(@message.body)==''
            flash[:alert]='Inserire un titolo e un contenuto valido'
            redirect_to '/profile'
            return
        end


        if @message.save
            flash[:alert]='Il messaggio è stato inviato'
            redirect_to '/profile'
            return
        else
            flash[:alert]="C'è stato un errore"
            redirect_to  '/profile'
            return
        end
    end

    def destroy
         @message = Message.find(params[:id]).delete
         flash[:alert]="Messaggio cancellato con successo"
     
         redirect_to '/profile', status: :see_other
    end


    def new_admin_message

        @message = Message.new
     if !current_user.has_role?(:moderator)
        redirect_to '/profile/'
     end      

    end
    
    def create_admin_message
        receivers=User.all

        receivers.each do |receiver|
            message=Message.new(admin_msg)
            message.sender_id=current_user.id
            message.receiver_id = receiver.id
            message.save
        end
     redirect_to '/profile/'
    end

    def new_support_message
        @message = Message.new   
    end

    def create_support_message
        users=User.all
        users.each do |user|
            if user.has_role?(:moderator)
              message=Message.new(support_msg)
              message.sender_id=current_user.id
              message.receiver_id=user.id
              message.subject='Ticket Supporto Utente'
              message.save
            end

        end
        redirect_to '/profile/'
    end

    def new_segnala_utente
        params[:username] = params[:username]
        @message=Message.new
    end

    def create_segnala_utente
        user=current_user.id
        admins=User.all
        admins.each do |admin|
            if admin.has_role?(:moderator)
                message=Message.new(segnala_msg)
                message.sender_id=user
                message.receiver_id=admin.id
                message.save
            end
        end
        redirect_to '/profile'
    end




    private

    def params_msg
        params.require(:message).permit(:subject, :body, :receive_email)

    end

    def admin_msg
        params.require(:message).permit(:subject, :body)
    end

    def support_msg
        params.require(:message).permit(:body)
    end
    def segnala_msg
        params.require(:message).permit(:subject,:body)
    end
end

