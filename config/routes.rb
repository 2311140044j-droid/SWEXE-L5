Rails.application.routes.draw do
  root "tweets#index"

  get  "/login"  => "sessions#new"
  post "/login"  => "sessions#create"
  delete "/logout" => "sessions#destroy", as: "logout"

  resources :users, only: [:new, :create]

  resources :tweets, only: [:index, :create] do
    member do
      post "like"
      post "unlike"
    end
  end
end

