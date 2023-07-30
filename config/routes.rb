Rails.application.routes.draw do
  resources :contact, controller: "contact_requests", as: "contact_requests", only: [:index, :destroy]
  resources :posts
  resources :projects, only: [:index]
  devise_for :admins, controllers: { registrations: "registrations"}
  post '/', to: "contact_requests#create"
  root 'application#home'
end
