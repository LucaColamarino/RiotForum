class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :username) #, :riot_user, :riot_tag
    end

    protected

    def after_sign_up_path_for(resource)  #resource è l'utente al momento loggato
        if resource.is_a?(User) && !resource.username.present?
          edit_profile_path
        else
          root_path
        end
    end

    def after_update_path_for(resource)
      if resource.is_a?(User) && resource.username.present?
        profile_path
      else
        edit_user_registration_path
      end
    end

    #ref: https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-edit-their-account-without-providing-a-password
    #solo che credo aggiorni TUTTI i parametri (password esclusa) senza chiedere la password
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
