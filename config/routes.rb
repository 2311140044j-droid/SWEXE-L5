Rails.application.routes.draw do
  root 'tweets#index'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :tweets do
    resource :like, only: [:create, :destroy]
  end
end
