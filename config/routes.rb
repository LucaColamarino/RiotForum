Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  root 'pages#scelta'
  get 'home', to: 'pages#home'
  post '/set_session/:value', to: 'sessions#set_session', as: 'set_session'
  get 'profile', to: 'pages#profile'
  get 'board', to: 'pages#board'
  get 'create_team', to: 'pages#create_team'
  get 'settings', to: 'pages#settings'
  get 'news', to: 'pages#news'
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
