Rails.application.routes.draw do
  
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  
  root 'pages#scelta'
  
  get 'home', to: 'pages#home'
  post '/set_session/:value', to: 'sessions#set_session', as: 'set_session'

  get 'profile', to: 'pages#profile'
  get 'edit_profile', to: 'pages#edit_profile'
  get 'board', to: 'pages#board'
  get 'create_team', to: 'pages#create_team'
  get 'your_team', to: 'pages#your_team'
  get 'settings', to: 'pages#settings'
  get 'news', to: 'newpost#news'
  get 'news/:id', to: 'newpost#show', constraints: {id: /\d+/}
  get 'news/newpost', to: 'newpost#newpost'
  post 'news/newpost', to: 'newpost#create'
  get 'news/:id/edit', to: 'newpost#edit'
  patch 'news/:id' , to: 'newpost#update'
  delete 'news/:id', to: 'newpost#destroy'

  get 'messages/new_admin_message', to: 'messages#new_admin_message'
  post 'messages/new_admin_message', to: 'messages#create_admin_message'

  get 'messages/new_support_message', to: 'messages#new_support_message'
  post 'messages/new_support_message', to: 'messages#create_support_message'


  resources :messages

  resources :notificas

  resources :ads
 

  get 'search_player', to: 'pages#search_player'
  get 'search_user', to: 'pages#search_user'
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
