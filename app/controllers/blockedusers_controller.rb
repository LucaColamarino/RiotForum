class BlockedusersController < ApplicationController


    def new
        @blocked_user=BlockedUser.new()
    end 

    def index
        @blocked_user=BlockedUser.where(user_id: current_user.id)

    end

    def create

    @blocked_user=BlockedUser.new(blocked_user_params)
        if @blocked_user.save
            redirect_to '/profile'
            flash[:notice]= 'Utente bloccato con successo'
        else
            redirect_to '/profile'
            flash[:alert]= 'Non sei riuscito a bloccare l utente'
        end
    end

    def destroy

        @blocked_user=BlockedUser.find_by(blocked_user_params)
        @blocked_user.destroy
        redirect_to '/profile'
        flash[:notice]= 'Utente sbloccato con successo'
    end

    private

    def blocked_user_params

        params.require(:blocked_user).permit(:user_id, :blocked_id)
    end




end