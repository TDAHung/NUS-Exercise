Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "feeds#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "sign_out", to: "sessions#destroy"

  get "discover", to: "discovers#index"
  get "/discover/album", to: "albums#index"
  get "photo", to: "photos#index"
  get "discover/photo", to: "photos#index"

end
