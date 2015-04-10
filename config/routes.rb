Rails.application.routes.draw do
  #get 'workload/index'
  get 'workload', to: 'workload#index'

  get 'workload/dashboard'

  post 'state/:id', to: 'projects#state'

  resources :projects
  resources :congressional_notifications, :path => 'cns'

  root to: 'projects#index'
  devise_for :users
  resources :users
end
