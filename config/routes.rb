require 'sidekiq/web'

Rails.application.routes.draw do
  resources :admin, only: [:index]

  resources :rates, only: [:index, :update]

  root 'rates#index'

  mount Sidekiq::Web, at: '/sidekiq'
end
