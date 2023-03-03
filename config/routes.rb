Rails.application.routes.draw do
  patch 'users_otp/enable'
  get 'users_otp/disable'
  devise_for :users, controllers: {
    sessions: 'sessions'
   }
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "posts#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
