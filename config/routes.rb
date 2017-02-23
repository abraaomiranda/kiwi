Rails.application.routes.draw do

  root to: 'home#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:create, :destroy]
  resources :home, only: :index
end
