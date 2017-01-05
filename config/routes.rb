Rails.application.routes.draw do
  root to: 'pages#index'
  resources :items, only: [:index, :show]

  get '/cart' => "carts#show", as: "cart"
  resources :categories, :path => '', only: [:show]
  
  resources :carts, only: [:create]
end
