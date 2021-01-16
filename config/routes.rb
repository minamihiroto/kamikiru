Rails.application.routes.draw do
  devise_for :users
  root 'comments#index'
  get 'comments/index'
  get 'comments/main'
  resources :machings, only: [:create, :update, :show]
  resources :messages, only: [:create]
  resources :notifications, only: [:index]
  resources :menus, only: [:create,:destroy]
  resources :cards
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
