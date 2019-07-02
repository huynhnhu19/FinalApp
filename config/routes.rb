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
      post :user_approved
      post :user_banned
      post :user_muted
      post :manage_user
      post :post_approved
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
      post 'report'
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
  get "/alert", to: "home#alert"

  namespace :admin do
    devise_for :admins, skip: :registrations
    root to: "admins#index"
    resources :persons, only: [:index, :show, :destroy] do
      collection do
        get 'person_index'
      end
    end
    resources :groups, only: [:index, :show, :destroy] do
      collection do
        get 'group_index'
      end
    end
    resources :posts, only: [:index, :show, :destroy] do
      collection do
        get 'post_index'
      end
    end
    resources :comments, only: [:index, :show, :destroy] do
      collection do
        get 'comment_index'
      end
    end
    resources :categories do
      collection do
        get 'category_index'
      end
    end
  end
end