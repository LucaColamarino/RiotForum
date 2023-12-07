Rails.application.routes.draw do
  resources :users
  resources :movies
  get "/users", to: "user#index"
  get "/create", to: "user#create"
  root :to => redirect('/user')
end
