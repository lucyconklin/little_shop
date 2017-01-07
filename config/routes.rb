Rails.application.routes.draw do
  root to: 'pages#index'
  resources :items, only: [:index, :show]

  get '/cart' => "carts#show", as: "cart"
  delete '/cart' => "carts#destroy"

  get '/orders' => "customers/orders#index"

  resources :categories, :path => '', only: [:show]

  resources :carts, only: [:create]
end
