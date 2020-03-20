Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  devise_for :users
  
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    post '/login', to: 'devise/sessions#create'
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  
  root "home#index"
  get  "/about" => "home#about"
end
