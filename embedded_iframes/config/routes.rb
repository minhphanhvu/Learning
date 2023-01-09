Rails.application.routes.draw do
  resources :stats, only: :index
  resources :embeddeds, only: [:show, :create, :edit]

  devise_for :users
  root to: 'welcome#index'
end
