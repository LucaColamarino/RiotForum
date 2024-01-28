Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'profile', to: 'pages#profile'
  get 'board', to: 'pages#board'
  get 'create_team', to: 'pages#create_team'
  get 'settings', to: 'pages#settings'
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
