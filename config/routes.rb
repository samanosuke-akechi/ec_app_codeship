Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :products do
    resources :cart_products, only: [:create]
    resource :cart_products, only: [:destroy]
  end
  resources :cart_products, only: [:index]
  get '/complete', to: 'homes"complete'
end