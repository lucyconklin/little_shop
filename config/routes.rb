Rails.application.routes.draw do
  root to: 'pages#index'
  get '/login' => "customers/sessions#attempt_login"
  post '/login' => "customers/sessions#login"
  get '/dashboard' => "customers#dashboard"
  get '/logout' => "customers/sessions#logout"

  scope '/admin' do
    root to: 'admins#index', as: 'admins'
    get '/login' => "admins/sessions#new", as: 'admin_login'
    post '/login' => "admins/sessions#create"
    get '/dashboard' => "admins#show", as: 'admin_dashboard'
  end

  resources :customers, only: [:new, :create]

  resources :items, only: [:index, :show]

  get '/cart' => "carts#show", as: "cart"
  post '/cart' => "carts#update"
  delete '/cart' => "carts#destroy"

  get '/orders' => "customers/orders#index"
  get '/order' => "customers/orders#show"

  resources :categories, :path => '', only: [:show]

  resources :carts, only: [:create]


end
