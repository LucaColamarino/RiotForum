class NewpostController < ApplicationController
  before_action :authenticate_user!, except: [:show, :news]
  before_action :check_admin, except: [:show, :news]

  

  def news
    @game = params[:game];
    url = URI.parse('https://euw1.api.riotgames.com/lol/platform/v3/champion-rotations');
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true if url.scheme == 'https'

    request = Net::HTTP::Get.new(url)
    request['X-Riot-Token'] = ENV['RIOT_API_KEY']

    @rotation_champs = JSON.parse(http.request(request).body)['freeChampionIds']
    
    @newpost=Newpost.all
    
  end

    def index
      @newposts = Newpost.all
    end
    
    def postsuccesso
      
    end
  
    def show
      @newpost=Newpost.find(params[:id])
      @user_id = @newpost.user_id

    end

    def newpost
      @newpost=Newpost.new
    end

    def create
      if user_signed_in?
        @newpost = current_user.newposts.build(post_params) 
      #current_user.newposts.build costruirà automaticamente un nuovo post associato all'utente corrente.
      # La chiave è l'utilizzo del metodo build su current_user.posts,
      # che sfrutta la relazione has_many tra User e Newpost 
      #per costruire un nuovo post associato all'utente corrente.

        if @newpost.save
          redirect_to '/news/'+@newpost.id.to_s
        else
        
        redirect_to '/news'
        flash[:warning]='Parametri vuoti non sono accettati'
        end
      else
        flash[:warning] = 'You must be logged in to create a post.'
        redirect_to '/news/'
      end

    end

    def edit

      if current_user.id== Newpost.find(params[:id]).user_id
        @newpost = Newpost.find(params[:id])
      else
        redirect_to '/news/'
      end
    end
    
    def update

        @newpost = Newpost.find(params[:id])
    
        if @newpost.update(post_params)
          flash[:warning]="La notizia è stata modificata"
          redirect_to '/news'
        else
          flash[:warning]="La notizia non è stata modificata, parametri non validi"
          redirect_to '/news'
        end
    end

    def destroy
     if current_user.id== Newpost.find(params[:id]).user_id
      @newpost = Newpost.find(params[:id])
      @newpost.destroy

  
      redirect_to '/news'
      flash[:warning]='La notizia è stata cancellata'
     else
      redirect_to '/news'
      flash[:warning]='La notizia non è stata cancellata, non hai i permessi'
     end
    end

    private

    def post_params
      if user_signed_in?
        params.require(:newpost).permit(:title, :content)
      end
    end

    def check_admin
      if !(current_user.has_role?(:moderator))
        flash[:warning] = 'You must be admin to create,delete or update a post'

        redirect_to '/news'
      end
    end

      

end
