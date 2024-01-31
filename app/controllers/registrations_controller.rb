class RegistrationsController < Devise::RegistrationsController

    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :riot_user, :riot_tag, :username)
    end
end
