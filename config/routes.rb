Rails.application.routes.draw do
  resources :messages
  resources :sessions
  resources :users

  root 'application#ban'

  match 'emailin', :to => 'messages#emailin', via: [:get, :post]
  match 'smsin', :to => 'messages#smsin', via: [:get, :post]
  
  get 'destroy_all', :to => 'messages#destroy_all'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  mount Resque::Server, :at => "/resque"
end
