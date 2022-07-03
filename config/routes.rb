Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sites, only: [:create, :index, :update, :destroy]
  resources :listens, only: [:create, :index, :update, :destroy]
  # resources :itens, only: [:index, :destroy]
  resources :notification_model, only: [:create, :index, :update, :destroy]
  resources :wanted_items, only: [:index, :update, :destroy]
  resources :task, only: [:index, :create, :destroy, :update]
  resources :user, only: [:create, :index, :update, :destroy]

  get '/queued_tasks/', to: "task#all_queued"
  delete '/queued_tasks/:id', to: "task#dequeue"
  # [:create, :index, :update, :destroy]

end
