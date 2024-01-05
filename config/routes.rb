Rails.application.routes.draw do
  get 'contents/new'

  resources :users
  resources :posts
  resources :songs, only: %i[index show new create edit update destroy] do
    collection do 
      get 'search'
    end
  end

  resources :artists, only: %i[index show new create edit update destroy]
  resources :movies
  resources :novels
  resources :comics
  resources :boards
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "top#index"

  get 'create_post', to: 'top#create_post'
  get 'create_board', to: 'top#create_board'
  get "login", to: 'user_sessions#new'
  post "login", to: 'user_sessions#create'
  delete "logout", to: 'user_sessions#destroy'
end
