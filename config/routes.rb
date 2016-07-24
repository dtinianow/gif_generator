Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "welcome#index"

  resources :users, only: [:new, :create, :show]
  resources :categories, only: [:index, :show]
  resources :gifs, only: [:index]

  namespace :admin do
    resources :categories, only: [:index, :new, :create]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
