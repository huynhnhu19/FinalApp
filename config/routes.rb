Rails.application.routes.draw do
  devise_for :admins
  get 'groups/index'
  get 'groups/show'
  get 'groups/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  devise_for :persons, :controllers => {sessions: "sessions"}

  resources :persons do
    resources :groups
  end

  resources :groups do
    resources :posts
    member do
      post :join
      delete :leave
    end
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
      get 'account'
      post 'account_setting'
      get 'person_profile'
      post 'profile_setting'
      get 'feed'
      post 'feed_setting'
      post 'follow'
      post "post_options"
    end
  end

  resources :posts do
  	resources :comments
    member do
      post 'vote'
    end
  end

  resources :posts do
    resources :comments
  end

  resources :comments do
    member do
      post 'vote'
    end
    collection do
      post "reply"
    end
  end

  resources :replies do
    member do
      post 'vote'
    end
  end

  get "/search", to: "home#search"

  namespace :admin do
    devise_for :admins, skip: :registrations
    root to: "admins#index"
    resources :persons, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :show, :destroy]
    resources :replies, only: [:index, :show, :destroy]
    resources :categories
  end
end