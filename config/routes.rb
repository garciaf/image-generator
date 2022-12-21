Rails.application.routes.draw do
  resources :image_requests, only: [:new, :create, :destroy, :show, :index] do
    resources :images, only: :create
  end

  # Defines the root path route ("/")
  root 'image_requests#index'
end
