Rails.application.routes.draw do
 
  resources :groups
  resources :user_groups
  resources :orders
  resources :order_details
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options :host => "localhost:3000"
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  
  root to: 'user#index'

  get '/friends', to: 'friend#friends_index'

  post '/friends', to: 'friend#add_friend'
  
  delete '/friends', to: 'friend#remove_friend'

  get '/all_notifications', to: 'notifications#showAllNotifications'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
end
