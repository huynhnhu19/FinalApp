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
    resources :replies
  end

end
