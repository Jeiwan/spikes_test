Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :invoices, only: [:index, :create]
    resources :requests, only: [:index, :create]
    patch "/settings/threshold" => "settings#set_threshold", as: :settings_threshold
    post "/requests/merge" => "requests#merge", as: :merge_requests
  end
  scope :admin do
    get "/products" => "products#index_admin", as: :admin_products
    patch "/products/:id/set_quantity_threshold" => "products#set_quantity_threshold", as: :admin_set_product_quantity_threshold
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
