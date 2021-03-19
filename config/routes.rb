Rails.application.routes.draw do
  root 'pages#index'

  resources :categories
  resources :products
end
