require 'sidekiq/web'

Rails.application.routes.draw do
  resources :microposts
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  if Rails.env.development?
    mount Sidekiq::Web, at: '/sidekiq'
  end
end
