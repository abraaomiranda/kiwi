Rails.application.routes.draw do

  root to: 'home#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    member do
      get :follows
      get :followers
    end
  end

  resources :posts, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy]
  resources :home, only: :index
end
