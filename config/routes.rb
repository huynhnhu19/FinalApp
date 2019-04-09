Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/show'
  get 'groups/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :persons
  root to: "home#index"

  resources :persons do
  	resources :posts
  end
  
  resources :posts do
  	resources :comments
  end

  resources :comments do
  	resources :replies
  end

  resources :persons do
    resources :groups
  end

end
