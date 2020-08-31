Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :mytweets do
  post :confirm, on: :collection
  end
end
