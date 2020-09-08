Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
  post :confirm, on: :collection
  end
  resources :users, only: [:new, :create, :show]
  root to: 'users#top'
end
