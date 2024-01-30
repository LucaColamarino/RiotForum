Rails.application.routes.draw do
<<<<<<< HEAD
  root 'pages#scelta'

  get 'home', to: 'pages#home'
=======
  devise_for :users
  root 'pages#home'
>>>>>>> 59817eccb985728f6489cd62254de3c4805170c5
  get 'profile', to: 'pages#profile'
  get 'board', to: 'pages#board'
  get 'create_team', to: 'pages#create_team'
  get 'settings', to: 'pages#settings'
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
