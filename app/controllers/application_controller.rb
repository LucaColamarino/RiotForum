class ApplicationController < ActionController::Base
    rescue_from CanCan::AccessDenied do
        flash[:error] = 'Accesso vietato per utenti non loggati'
        redirect_to home_path
    end
end
