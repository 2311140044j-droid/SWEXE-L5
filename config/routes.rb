Rails.application.routes.draw do
  root "tweets#index"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :users, only: [:new, :create, :show, :edit, :update]

  resources :tweets, only: [:index, :create] do
    post "like", on: :member
    post "unlike", on: :member
  end
end

