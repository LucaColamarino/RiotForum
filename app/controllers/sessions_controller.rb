class SessionsController < ApplicationController

    def set_session
        session[:game] = params[:value];
        redirect_to home_path
    end
end
