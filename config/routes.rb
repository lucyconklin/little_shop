Rails.application.routes.draw do
  root to: 'pages#index'
  get '/login' => "customers/sessions#attempt_login"
  post '/login' => "customers/sessions#login"
  get '/dashboard' => "customers#dashboard"

  resources :customers, only: [:new, :create]

  resources :items, only: [:index, :show]

  get '/cart' => "carts#show", as: "cart"
  post '/cart' => "carts#update"
  delete '/cart' => "carts#destroy"

  get '/orders' => "customers/orders#index"

  resources :categories, :path => '', only: [:show]

  resources :carts, only: [:create]


end
