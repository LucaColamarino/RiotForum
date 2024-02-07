# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

-------------------------------------
aristotele1 "prima api call in edit_profile + piccoli fix"3-2-24
-------------------------------------
- aggiunte gem figaro (per env variables dove mettere l'api key), json
 -> Se usate figaro come in sto tutorial consigliato dai prof https://blog.devgenius.io/what-are-environment-variables-in-rails-6f7e97a0b164
vanno scritte in config/application.yml e diventano da sole env variables.
application.yml deve stare in .gitignore

- icona del profilo loggato sostituita dall'email, dropdown cambiato perchè si apriva oltre la finestra

- aggiunta colonna username a User (riot name e riot tag non servono per ora ma stanno ancora come attributi)

- i metodi delle api stanno tutti in RiotGamesApi in app/services (non era obbligatorio, solo per modularità ig, ma si potrebbe anche cambiare)

- inserita api call per trovare summoner_name(di lol) in edit_profile

- dalla registrazione
-> se NON si scrive l'username si viene reindirizzati a edit_profile (il profilo 
 non è ancora salvato/fissato tho)
-> se si scrive l'username si viene reindirizzati alla home, MA username non è stato salvato nel database di quell'oggeto, idk come farlo

-------------------------------------
-------------------------------------

------------------------------------------------
7-2-2024
aristotele1 "pagina giocatore lol cercato, bozza profilo, funzione cambio username del profilo" 

- nelle match history mancano le immagini di rune,spell,inventario perchè non so come metterle (c'è un pacchetto, ddragon qualcosa, che puoi scaricare, ma sulla mia vm pesa troppo ig). Manca anche l'overview dei due team a destra.

- sia nel giocatore cercato che profilo mancano rank e stats generali. La api c'è e funziona, è solo che non so come accedere agli elementi di sto Set[LeagueEntryDTO]

