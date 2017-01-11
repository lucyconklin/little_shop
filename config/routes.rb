Rails.application.routes.draw do
  root to: 'pages#index'
  get '/login' => "customers/sessions#attempt_login"
  post '/login' => "customers/sessions#login"
  get '/dashboard' => "customers#dashboard"
  get '/logout' => "customers/sessions#logout"
  get '/checkout' => "checkout#checkout"

  scope '/admin' do
    root to: 'admins#index', as: 'admins'
    put '/orders' => "admins/orders#update"
    get '/login' => "admins/sessions#new", as: 'admin_login'
    post '/login' => "admins/sessions#create"
    delete '/logout' => "admins/sessions#destroy", as: 'admin_logout'
    get '/dashboard' => "admins#show", as: 'admin_dashboard'
    get '/items' => "items#index", as: 'items'
    get '/items/:id/edit' => 'items#edit', as: 'edit_admin_item'
  end
  resources :admins, only: [:edit, :update]

  resources :customers, only: [:new, :create]

  resources :items, only: [:index, :show, :update]

  get '/cart' => "carts#show", as: "cart"
  post '/cart' => "carts#update"
  delete '/cart' => "carts#destroy"

  get '/orders' => "customers/orders#index", as: 'customer_orders'
  get '/order' => "customers/orders#show"

  resources :categories, :path => '', only: [:show]

  resources :carts, only: [:create]


end
