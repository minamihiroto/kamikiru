Rails.application.routes.draw do
  devise_for :users
  root 'comments#index'
  get 'comments/index'
  get 'comments/main'
  resources :machings, only: [:create, :update]
  resources :messages, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
