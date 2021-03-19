Rails.application.routes.draw do
  root 'pages#index'

  resources :categories
end
