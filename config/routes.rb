Rails.application.routes.draw do
  root 'pages#index'

  devise_for :sellers
  devise_for :users
  
  scope module: "sellers" do
    resources :products, except: %i[index show]
  end

  resources :products, only: %i[index show]
end
