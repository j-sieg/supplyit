Rails.application.routes.draw do
  get 'line_items/create'
  get 'line_items/update'
  get 'line_items/destroy'
  root 'pages#index'

  devise_for :sellers
  devise_for :users
  
  scope module: "sellers" do
    resources :products, except: %i[index show]
  end

  get '/checkout', to: 'carts#index'

  resources :carts, only: %i[destroy]
  resources :products, only: %i[index show]
  resources :line_item, only: %i[create update destroy]
end
