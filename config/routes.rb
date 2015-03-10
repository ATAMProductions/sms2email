Rails.application.routes.draw do
  resources :messages

  resources :users

  root 'application#ban'

  match 'emailin', :to => 'messages#emailin', via: [:get, :post]
end
