Rails.application.routes.draw do
  root 'home#index'
  get 'home/about'

  resources :friends
end
