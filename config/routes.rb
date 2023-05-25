Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")  
  resources :sites, only: [:create, :index, :update, :destroy]
  resources :listens, only: [:create, :index, :update, :destroy]  
  resources :notification_models, only: [:create, :index, :update, :destroy]  
  resources :tasks, only: [:index, :create, :destroy, :update]
  resources :user, only: [:create, :index, :update, :destroy]

  get '/queued_tasks/', to: "tasks#all_queued"
  delete '/queued_tasks/:id', to: "tasks#dequeue"
  post '/queued_tasks/:id', to: "tasks#add_queue"
  put '/queued_tasks/:id', to: "tasks#fix_queue"
  get '/tasks/history', to: "tasks#history_tasks"

  get '/reports/', to: "reports#index"
  delete '/reports/clean/:id', to: "reports#clean"

  resources :logs, only: [:index]
end
