Rails.application.routes.draw do
  namespace :admin do
    root 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[ index show edit update destroy ]
    resources :boards, only: %i[ index show edit update destroy ]
    resources :answers, only: %i[ index show edit update destroy ]
    resources :posts, only: %i[ index show edit update destroy ]
    resources :songs, only: %i[ index show edit update destroy ]
    resources :artists, only: %i[ index show edit update destroy ]
    resources :comics, only: %i[ index show edit update destroy ]
    resources :novels, only: %i[ index show edit update destroy ]
    resources :movies, only: %i[ index show edit update destroy ]
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get 'contents/new'

  resources :users, only: %i[new show create destroy] do
    collection do 
      get 'artist_lists', to: 'artist_lists#index'
      get 'likes', to: 'likes#index'
    end
  end
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[show edit update]
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

  resources :boards do
    resources :answers, only: %i[index show new create destroy] do
      collection do
        get :save_session
      end
    end
  end

  resources :likes, only: %i[create destroy]
  resources :artist_lists, only: %i[create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "top#index"

  get 'create_post', to: 'top#create_post'
  get 'create_board', to: 'top#create_board'
  get 'create_answer', to: 'top#create_answer'
  get "login", to: 'user_sessions#new'
  post "login", to: 'user_sessions#create'
  delete "logout", to: 'user_sessions#destroy'
end
