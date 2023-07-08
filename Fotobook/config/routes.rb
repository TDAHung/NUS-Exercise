Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "feeds#index"
  get "feeds/photos", to: "feed_photos#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "sign_out", to: "sessions#destroy"

  scope "discovers" do
    get "/", to: "discovers#index", as: "discover"
    get "/photos", to: "discover_photos#index", as: "discover_photos"
    get "/photos/:id", to: "discover_user_photos#index"
    get "/albums/:id", to: "discover_user_albums#index"
    get "/followees/:id", to: "discover_user_followees#index"
    get "/followers/:id", to: "discover_user_followers#index"
  end
  resources :album_attachments, :profiles, :photos, :albums
  resources :followees, only: [:index, :create, :destroy]
  resources :followers, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]

end
