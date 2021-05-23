Rails.application.routes.draw do
  resources :posts
  root "posts#index"

  # non-restful routes for creating friends
  resources :friends, only: %i[create update destroy] do
    member do
      post "/", action: "create"
      patch "/", action: "update"
      delete "/", action: "destroy"
    end
  end

  resources :comments, only: %i[create destroy]
  resources :like_relations, only: %i[create destroy]
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
