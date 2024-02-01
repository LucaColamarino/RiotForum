class SessionsController < ApplicationController

    def set_session
        if (params[:value])
            session[:game] = params[:value];
        else
            session[:game] = 'VALO'
        end
        redirect_to home_path
    end
end
