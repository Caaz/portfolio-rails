Rails.application.routes.draw do
  resources :contact, controller: "contact_requests", as: "contact_requests"
  resources :posts
  resources :projects, only: [:index]
  devise_for :admins, controllers: { registrations: "registrations"}
  
  root 'application#home'
end
