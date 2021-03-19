Rails.application.routes.draw do
  root 'pages#index'

  resources :categories, except: %i[new]
  resources :products

  devise_for :sellers
end
