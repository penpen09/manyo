Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do
  post :confirm, on: :collection
  end
end
