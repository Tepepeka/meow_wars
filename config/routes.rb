Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "products#index"
  devise_for :users, :controllers => {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users, only: [:show]
  resources :products, only: [:show] do
    resources :comments
  end
  resources :orders, only: [:show, :index]

  # Turbo cart
  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  post 'cart/add_remove_product'

  # Stripe
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  # Admin
  namespace :admin do
    resources :users
    resources :products
  end

end