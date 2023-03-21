Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "products#index"  
  devise_for :users
  resources :products, only: [:show]
  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  post 'cart/add_single'
  post 'cart/remove_single'

  # Stripe
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

end