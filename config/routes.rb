Rails.application.routes.draw do
  resources :messages

  resources :users

  root 'application#ban'

  post 'emailin', :to => 'messages#emailin'
end
