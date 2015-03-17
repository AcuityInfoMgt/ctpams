Rails.application.routes.draw do
  resources :projects

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
