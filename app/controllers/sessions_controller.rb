class SessionsController < Devise::SessionsController

    def create
        self.resource = warden.authenticate!(auth_options)
        if resource.banned?
          sign_out
          flash[:alert] = "You are banned from logging in."
          redirect_to root_path(banned:1)
        else
          sign_in(resource_name, resource)
          respond_with resource, location: after_sign_in_path_for(resource)
        end
    end

    def set_session
        if (params[:value])
            session[:game] = params[:value];
        else
            session[:game] = 'VALO'
        end
        redirect_to home_path
    end  
end
