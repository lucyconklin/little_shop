Rails.application.routes.draw do
  root to: 'pages#index'
  get '/login' => "customer/sessions#new", as: "login"
  
  resources :items, only: [:index, :show]

  get '/cart' => "carts#show", as: "cart"
  delete '/cart' => "carts#destroy"

  resources :categories, :path => '', only: [:show]

  resources :carts, only: [:create]


end
