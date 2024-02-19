class ApplicationController < ActionController::Base
    rescue_from CanCan::AccessDenied do
        flash[:error] = 'Accesso vietato per utenti non loggati'
        redirect_to home_path
    end

    def username_exists?(username)
        return false if username.nil?
        query = User.find_by(username: username)
        return false if query.nil?
        return query.username.present?
    end
end
