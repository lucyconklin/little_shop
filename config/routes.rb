Rails.application.routes.draw do
  root to: 'pages#index'
  resources :items, only: [:index, :show]

  resources :categories, :path => '', only: [:show]
  
  resources :carts, only: [:create]
end
