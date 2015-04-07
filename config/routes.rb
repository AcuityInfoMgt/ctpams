Rails.application.routes.draw do
  resources :projects
  resources :congressional_notifications

  root to: 'projects#index'
  devise_for :users
  resources :users
end
