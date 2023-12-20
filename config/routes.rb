Rails.application.routes.draw do

  resources :users
  resources :posts
  resources :songs, only: %i[index show new create edit update destroy] do
    collection do 
      get 'search'
    end
  end

  resources :artists, only: %i[index show new create edit update destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "top#index"

  get "login", to: 'user_sessions#new'
  post "login", to: 'user_sessions#create'
  delete "logout", to: 'user_sessions#destroy'
end
