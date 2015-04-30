Rails.application.routes.draw do

  get 'workload/summary', to: 'workload#index'
  get 'workload/dashboard'
  get 'workload/my_projects'

  patch 'state/:id', to: 'projects#state'

  resources :projects
  resources :congressional_notifications, :path => 'cns'

  root to: 'workload#index'
  devise_for :users, :path_prefix => 'd'
  resources :users


end
