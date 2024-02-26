Rails.application.routes.draw do
  
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations', sessions: 'sessions' }

  root 'pages#home' 

  
  post '/set_session/:value', to: 'sessions#set_session', as: 'set_session'

  get 'profile', to: 'pages#profile'
  get 'edit_profile', to: 'pages#edit_profile'
  get 'board', to: 'pages#board'
  #get 'create_team', to: 'pages#create_team'
  #get 'your_team', to: 'pages#your_team'
  get 'settings', to: 'pages#settings'
  get 'news', to: 'newpost#news'
  get 'news/:id', to: 'newpost#show', constraints: {id: /\d+/}
  get 'news/newpost', to: 'newpost#newpost'
  post 'news/newpost', to: 'newpost#create'
  get 'news/:id/edit', to: 'newpost#edit'
  patch 'news/:id' , to: 'newpost#update'
  delete 'news/:id', to: 'newpost#destroy', as:'delete_newpost'

  get 'messages/new_admin_message', to: 'messages#new_admin_message'
  post 'messages/new_admin_message', to: 'messages#create_admin_message'

  get 'messages/new_support_message', to: 'messages#new_support_message'
  post 'messages/new_support_message', to: 'messages#create_support_message'

  get 'profile/page_to_ban', to: 'pages#page_to_ban'
  post 'profile/page_to_ban', to: 'pages#ban_user'

  get 'search_user/new_segnala_utente/:username', to: 'messages#new_segnala_utente'
  post 'search_user/new_segnala_utente', to: 'messages#create_segnala_utente'
  get 'teams/', to: 'teams#show'
  get 'teams/new', to: 'teams#new'
  post 'teams/new', to: 'teams#create'
  patch 'teams/:id' , to: 'teams#update', as: 'team'
  delete 'teams/', to: 'teams#destroy'

  get 'requests/new', to: 'requests#new'
  #get 'requests/:id', to: 'requests#show'
  post 'requests/new', to: 'requests#create'
  delete 'requests/:id', to: 'requests#destroy', as: 'request'

  get '/blocked_user', to: 'blockedusers#index'
  #get '/blocked_user/:id', to: 'blockedusers#new', as: 'blocked_user'
  post '/blocked_user/:id', to: 'blockedusers#create'
  delete '/blocked_user/:id', to: 'blockedusers#destroy'



  get '/teams/messaggioteams/:team_id', to: 'messaggioteams#show', constraints: {team_id: /\d+/}, as: 'chat_team'
  get '/teams/messaggioteams/new/:team_id', to: 'messaggioteams#new'
  post '/teams/messaggioteams/new/:team_id', to: 'messaggioteams#create', as:'chat_team_new'
  get '/teams/messaggioteams/:team_id/edit', to: 'messaggioteams#edit', as: 'chat_team_edit'
  patch '/teams/messaggioteams/:team_id/edit' , to: 'messaggioteams#update'
  delete '/teams/messaggioteams/:team_id', to: 'messaggioteams#destroy'

  resources :messages

  resources :ads

  resources :invitations


 
  get 'search_player', to: 'pages#search_player'
  get 'search_user', to: 'pages#search_user'

  post 'send_friend_request', to: 'pages#send_friend_request'
  delete 'destroy_friendship', to: 'pages#destroy_friendship'


  get 'posta', to: 'pages#posta'
  # get '/your_messages', to: 'pages#your_messages'
  #get '/your_messages', to: 'messages#index'
  # get '/your_notifications', to: 'pages#your_notifications'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
