Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  devise_for :users
  root 'comments#index'
  get 'comments/index'
  get 'comments/main'
  resources :machings, only: [:create, :update, :show]
  resources :messages, only: [:create]
  resources :notifications, only: [:index]
  resources :menus, only: [:create,:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
