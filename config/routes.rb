Rails.application.routes.draw do

  root to: 'home#index'

  devise_for :users, path: 'auth'

  resources :users, only: [:index, :show] do
    member do
      get :follows
      get :followers
    end
  end

  resources :posts, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :home, only: :index

  mount ActionCable.server => '/cable'
end
