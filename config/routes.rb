Rails.application.routes.draw do

  get 'comments/create'
  get 'comments/destroy'
  get 'create/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controller: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  } 

  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    post '/login', to: 'devise/sessions#create'
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  
  root "home#index"
  get  "/about" => "home#about"
  resources :users, only: %i[show edit update]
  resources :posts
  resources :likes, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  
end
