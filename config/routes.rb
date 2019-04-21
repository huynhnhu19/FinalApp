Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/show'
  get 'groups/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  devise_for :persons

  resources :persons do
    resources :groups
  end
  
  resources :groups do
    resources :posts
  end

 resources :persons do
    resources :posts
  end

  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :replies
  end

  resources :groups do
    member do
      post :join
    end
  end

  # resources :groups do
  #   member do
  #     post :create_post
  #   end
  # end

end
