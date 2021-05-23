Rails.application.routes.draw do
  resources :posts
  root "posts#index"

  # non-restful routes for creating friends
  post "friend/:friend_id", to: "friends#create"
  patch "friend/:friend_id", to: "friends#update"
  delete "friend/:friend_id", to: "friends#destroy"

  # resources :friendships
  resources :comments, only: %i[create destroy]
  resources :like_relations, only: %i[create destroy]
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
