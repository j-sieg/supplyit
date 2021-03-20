Rails.application.routes.draw do
  root 'pages#index'

  devise_for :sellers
  
  scope module: "sellers" do
    resources :products, except: %i[index show]
  end

  resources :categories, except: %i[new]
  resources :products, only: %i[index show]

end
