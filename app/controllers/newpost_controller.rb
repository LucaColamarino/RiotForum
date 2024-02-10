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

    # GET /newposts
    def index
      @newposts = Newpost.all
    end
  
    # GET /newposts/1
    def show
      @newpost=Newpost.find(params[:id])
    end

    def newpost
      @newpost=Newpost.save
    end

    def create
    end
      

end
