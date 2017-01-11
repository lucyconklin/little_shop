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
    get '/logout' => "admins/sessions#destroy", as: 'admin_logout'
    delete '/logout' => "admins/sessions#destroy"
    get '/dashboard' => "admins#show", as: 'admin_dashboard'
    get '/items' => "admins/items#index", as: 'admin_items'
    get '/items/:id/edit' => 'admins/items#edit', as: 'edit_admin_item'
  end
  resources :admins, only: [:edit, :update]

  resources :customers, only: [:new, :create]

  resources :items, only: [:index, :show]

  patch '/items/:id' => 'admins/items#update'
  get '/cart' => "carts#show", as: "cart"
  post '/cart' => "carts#update"
  delete '/cart' => "carts#destroy"

  get '/orders' => "customers/orders#index", as: 'customer_orders'
  get '/order' => "customers/orders#show"

  resources :categories, :path => '', only: [:show]

  resources :carts, only: [:create]


end
