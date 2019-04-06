Rails.application.routes.draw do
  resources :admin, only: [:index]

  root 'rates#index'
end
