Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    post :confirm, on: :collection
  end
  resources :users, only: [:new, :create, :show]
  root to: 'users#new'
end
