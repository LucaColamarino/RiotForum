require 'net/http' 
require 'json'   

class RiotGamesApi

    @@version = '14.2.1'

    #----------- RIOT USER --------------#
    def self.find_riot_user
    end

    #----------- LOL SUMMONER --------------#

    #nella form per la ricerca la regione sarà anch'essa una variabile
    #PLATFORM_URL = 'https://#{region}.api.riotgames.com'
    PLATFORM_URL = 'https://euw1.api.riotgames.com'   #per le developer api

    def self.find_summoner(summoner_name)
        
        
        endpoint = "/lol/summoner/v4/summoners/by-name/#{summoner_name}"

        uri = URI.parse("#{PLATFORM_URL}#{endpoint}")
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

    REGION_URL = "https://europe.api.riotgames.com"

    def self.find_byRiotId(name, tag)
    endpoint = "/riot/account/v1/accounts/by-riot-id/#{name}/"

        uri = URI.parse("#{REGION_URL}#{endpoint}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true  # Use SSL for secure communication

        request = Net::HTTP::Get.new(uri.request_uri)
        request['X-Riot-Token'] = ENV["RIOT_API_KEY"]

        response = http.request(request)

        if response.code.to_i == 200  #successo
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

    def self.find_byPuuid(puuid)
        endpoint = "/lol/summoner/v4/summoners/by-puuid/#{puuid}"

        uri = URI.parse("#{PLATFORM_URL}#{endpoint}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true  # Use SSL for secure communication

        request = Net::HTTP::Get.new(uri.request_uri)
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

    def self.getMatchList(puuid)
        endpoint = "/lol/match/v5/matches/by-puuid/#{puuid}/ids"

        uri = URI.parse("#{REGION_URL}#{endpoint}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true  # Use SSL for secure communication

        request = Net::HTTP::Get.new(uri.request_uri)
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

    def self.getMatch(matchId)
        endpoint = "/lol/match/v5/matches/#{matchId}"

        uri = URI.parse("#{REGION_URL}#{endpoint}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true  # Use SSL for secure communication

        request = Net::HTTP::Get.new(uri.request_uri)
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

    #----------- versioni migliori(per non essere ridondanti)
        #le 3 prima possono essere 1 funzine con un altro argomento all'inizio
        #che magari, a seconda che il valore sia 'puuid','id','username' cambia gli
        #endpoint, salvati anch'essi come var di classe come @@version.
        #unica cosa è richiedere il # di args giusto a seconda di cosa si sceglie

    #----------- VALO *** --------------#

    def self.find_#come si chiama su valo
    end

end
