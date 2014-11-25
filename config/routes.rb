Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :invoices, only: [:index, :create]
    resources :requests, only: [:index, :create]
    post "/settings/threshold" => "settings#set_threshold", as: :settings_threshold
  end

  resources :users, only: [:show]
  get "/cart" => "users#cart", as: :cart
  
  resources :products, only: [:index] do
    post "/add_to_cart" => "products#add_to_cart", as: :add_to_cart
    post "/remove_from_cart" => "products#remove_from_cart", as: :remove_from_cart
  end

  resources :orders, only: [:create]

  root to: 'products#index'
end
