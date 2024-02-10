class NewpostController < ApplicationController

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
    end

    def newpost
      @newpost=Newpost.new
    end

    def create
      @newpost=Newpost.new(post_params)

      if @newpost.save
        redirect_to '/news/'+@newpost.id.to_s
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def post_params
      params.require(:newpost).permit(:title, :content)
    end

      

end
