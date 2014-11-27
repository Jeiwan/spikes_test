Rails.application.routes.draw do
  get 'dashboard/show'

  devise_for :users

  authenticate :user, lambda { |u| u.admin?  } do
    namespace :admin do
      resources :invoices, only: [:index, :new, :create]
      resources :requests, only: [:index, :new, :create, :edit, :update] do
        resources :invoices, only: [:new, :create]
        post "/merge" => "requests#merge", as: :merge, on: :collection
        patch "/confirm" => "requests#confirm", as: :confirm
      end
      resource :dashboard, only: [:show], controller: :dashboard
      patch "/settings/threshold" => "settings#set_threshold", as: :settings_threshold

      root to: 'admin/dashboard#show'
    end
    scope :admin do
      get "/orders" => "orders#index_admin", as: :admin_orders
      get "/products" => "products#index_admin", as: :admin_products
      patch "/products/:id/set_quantity_threshold" => "products#set_quantity_threshold", as: :admin_set_product_quantity_threshold
    end
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
