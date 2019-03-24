Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'post/new'
  get 'post/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :persons
  root to: "home#index"

  resources :persons do
  	resources :posts
  end
end
