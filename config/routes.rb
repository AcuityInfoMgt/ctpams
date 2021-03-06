Rails.application.routes.draw do

  get 'workload/summary', to: 'workload#index'
  get 'workload/dashboard'
  get 'workload/my_projects'

  patch 'state/:id', to: 'projects#state'

  resources :projects
  resources :clearances
  resources :congressional_notifications, :path => 'cns'

  root to: 'workload#index'
  devise_for :users
  resources :users


end
