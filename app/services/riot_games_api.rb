require 'net/http' 
require 'json'      

class RiotGamesApi

    #----------- RIOT USER --------------#
    def self.find_riot_user
    end

    #----------- LOL SUMMONER --------------#

    #nella form per la ricerca la regione sarà anch'essa una variabile
    #BASE_URL = 'https://#{region}.api.riotgames.com'
    BASE_URL = 'https://euw1.api.riotgames.com'

    def self.find_summoner(summoner_name)
        
        
        endpoint = "/lol/summoner/v4/summoners/by-name/#{summoner_name}"

        uri = URI.parse("#{BASE_URL}#{endpoint}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true  # Use SSL for secure communication

        request = Net::HTTP::Get.new(uri.request_uri)

        #Header
        #deve essere una variabile d'ambiente chiamata cosi
        #Se usate figaro come in sto tutorial consigliato dai prof https://blog.devgenius.io/what-are-environment-variables-in-rails-6f7e97a0b164
        #vanno scritte in config/application.yml e diventano da sole env variables
        request['X-Riot-Token'] = ENV["RIOT_API_KEY"]

        response = http.request(request)

        if response.code.to_i == 200  #successo
            puts "HTTP Status Code: #{response.code}"
            return {
                body: JSON.parse(response.body),
                code: response.code.to_i
            }
        else                          #errore non definito
            return {
                body: "Error: #{response.code}, #{response.body}",
                code: response.code.to_i
            }
        end
    end

    #----------- VALO *** --------------#

    def self.find_#come si chiama su valo
    end

end
