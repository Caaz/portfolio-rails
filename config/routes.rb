Rails.application.routes.draw do
  resources :posts
  resources :projects, only: [:index]
  devise_for :admins, controllers: { registrations: "registrations"}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'application#home'
end
