Rails.application.routes.draw do
  resources :image_requests, only: [:new, :create, :destroy] do
    resources :images, only: :create
  end

  # Defines the root path route ("/")
  root 'home#index'
end
