Rails.application.routes.draw do
  resources :orders
  resources :order_details
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options :host => "localhost:3000"
  devise_for :users
  root to: 'user#index'

  get '/friends', to: 'friend#friends_index'

  post '/friends', to: 'friend#add_friend'
  
  delete '/friends', to: 'friend#remove_friend'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
end
