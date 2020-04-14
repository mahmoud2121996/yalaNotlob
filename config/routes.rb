Rails.application.routes.draw do
 
  resources :groups
  resources :user_groups
  resources :orders
  resources :order_details
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options :host => "localhost:3000"
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  
  root to: 'user#index'

  get '/friends/search/:input', to: 'friend#search'

  get '/friends', to: 'friend#friends_index'

  post '/friends', to: 'friend#add_friend'
  
  delete '/friends', to: 'friend#remove_friend'

  get '/all_notifications', to: 'notifications#showAllNotifications'

  get '/join/:order_id', to: 'notifications#join'
  get '/cancel/:order_id', to: 'notifications#cancel'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
end
