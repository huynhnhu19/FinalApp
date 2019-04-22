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
    member do
      get 'profile'
      get 'overview'
      get 'comments'
      get 'saved'
      get 'saved'
      get 'hidden'
      get 'upvoted'
      get 'upvoted'
      get 'downvoted'
      get 'all_settings'
      post 'account_setting'
      get 'account'
      post 'profile_setting'
      get 'user_profile'
      post 'feed_setting'
      get 'feed'
    end
  end

  resources :posts do
  	resources :comments
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

end
