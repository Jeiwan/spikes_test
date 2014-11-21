Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :invoices, only: [:index, :new, :create]
  end

  root to: 'admin/invoices#index'
end