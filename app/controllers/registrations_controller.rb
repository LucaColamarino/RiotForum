class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :username) #, :riot_user, :riot_tag
    end

    #override
    def create
      super do |resource|
        if resource.is_a?(User)
          resource.add_role(:user)


          if request.get? && !resource.username.present?
            # Affinchè non mi dia errore quando apro la pagina per la prima volta
            return
          end
          username = resource.username
          if username_valid?(username)
            if !username_exists?(username)
              resource.update(username: username)
              
            else
              flash.now[:error] = "Username già in questo sito. Riprova"
              redirect_to new_user_registration_path(error: 'existing')
              return
            end
          else
            flash.now[:error] = "Username inesistente. Riprova"
            redirect_to new_user_registration_path(error: 'unknown')
            return
          end


        end
      end
    end

    def delete_account
      @user= User.find(current_user.id)
      @user.destroy
      redirect_to root_path
    end

    def destroy
        current_user.destroy
        sign_out(current_user)
        redirect_to root_path, notice: "Account cancellato"   
    end

    # def edit
    #     @user = current_user
    #     if resource.is_a?(User) && params[:username].present?
    #       username = RiotGamesApi.find_summoner(params[:username])
    #       if user[:code] == 200 && user[:body]["name"]==params[:username]
    #         resource.username = user[:code].to_s
    #         render 'profile'
    #       else
    #         redirect_to root_path
    #       end
    #     end
    # end
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


    def username_valid?(username)
      summoner = RiotGamesApi.find_summoner(username)
      if summoner[:code] == 200
        summoner_name = summoner[:body]["name"]
  
        return summoner_name == username
      end
    end

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end


end
