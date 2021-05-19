Rails.application.routes.draw do
  resources :posts
  root "users#index"
  resources :friendships
  resources :comments, only: %i[create destroy]
  resources :like_relations, only: %i[create destroy]
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
