Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sites, only: [:create, :index, :update, :destroy]
  resources :listens, only: [:create, :index, :update, :destroy]
  resources :itens, only: [:index, :destroy]
   # [:create, :index, :update, :destroy]
end
