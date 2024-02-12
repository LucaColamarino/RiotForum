class MessagesController < ActionController::Base

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
        receiver= User.find_by(email: params_msg[:receive_email])
        if receiver.nil?
            redirect_to profile_path
        end

        @message=Message.new(params_msg)
        @message.sender_id = current_user.id
        @message.receiver_id = receiver.id


        if @message.save
            redirect_to profile_path
        else
            render :new
        end
    end

    def destroy
         @message = Message.find(params[:id])
         @message.destroy
     
         redirect_to '/messages', status: :see_other
    end



    private

    def params_msg
        params.require(:message).permit(:subject, :body, :receive_email)

    end











end

