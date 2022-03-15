require 'sidekiq/web'

Rails.application.routes.draw do
  resources :patients
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount Sidekiq::Web, at: '/sidekiq'
end
