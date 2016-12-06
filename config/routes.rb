Rails.application.routes.draw do

  get 'filter_districts_by_province' => 'address_lists#filter_districts_by_province'
  get 'filter_wards_by_district' => 'address_lists#filter_wards_by_district'
  
  get 'carts/show'


  root 'product/products#index'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'user/users#new'
  get '/login', to: 'user/sessions#new'
  post '/login', to: 'user/sessions#create'
  delete '/logout', to: 'user/sessions#destroy'
  get '/carts', to: 'order/carts#show'
  delete  'cartdetails/destroy' , to: 'order/cartdetails#destroy'
  put  'cartdetails/update', to: 'order/cartdetails#update'
  delete 'carts/destroy', to: 'order/carts#destroy'
  put 'orders/update', to: 'order/orders#update'
  post 'orders/new', to: 'order/orders#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, module: 'user'
  resources :products , module: 'product', only: [:index,:show]
  resources :address_lists, module: 'user', only: [:index, :new, :create, :edit, :destroy]
  resources :carts , module: 'order', only: [:show, :destroy]
  resources :cartdetails , module: 'order' , only: [:create, :update, :destroy]
  resources :categories, module: 'product', only: [:index,:show]
  resources :sessions, module: 'user', only: [:new, :create, :destroy]
  resources :orders, module: 'order'
end