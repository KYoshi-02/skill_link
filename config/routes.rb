Rails.application.routes.draw do
  get 'users/index'
  
  root "home#index"
  
  resources :users, only: [:index]
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
