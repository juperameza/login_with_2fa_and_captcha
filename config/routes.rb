Rails.application.routes.draw do
  resources :clients
  resources :equipment
  patch 'users_otp/enable'
  get 'users_otp/disable'
  devise_for :users, :path_prefix => "my", controllers: {
    sessions: 'sessions',
    registrations: 'users/registrations'
   }
   resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "equipment#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
