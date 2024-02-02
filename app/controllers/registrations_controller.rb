class RegistrationsController < Devise::RegistrationsController

    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :username, :riot_user, :riot_tag)
    end

    protected

    def after_sign_up_path_for(resource)  #resource è l'utente al momento loggato
        if resource.is_a?(User) && !resource.username.present?
          edit_profile_path
        else
          root_path
        end
    end
end
