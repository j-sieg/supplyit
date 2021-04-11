Rails.application.routes.draw do
  root 'pages#index'

  devise_for :sellers
  devise_for :users

  namespace :sellers do
    resources :products
    resources :orders, only: %i[index show]
  end

  get '/store', to: 'store#index'
  get '/checkout', to: 'orders#new'

  resources :carts, only: %i[destroy]
  resources :products, only: %i[index show]
  resources :line_items, only: %i[create destroy]
  resources :orders, only: %i[index show create]
end
