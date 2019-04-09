require 'sidekiq/web'

Rails.application.routes.draw do
  resources :admin, only: [:index]

  resources :rates, only: [:index, :update]

  post '/update_rates_data' => 'rates#update_rates_data'
  root 'rates#index'

  mount Sidekiq::Web, at: '/sidekiq'
end
