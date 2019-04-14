Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  devise_for :persons

  resources :persons do
  	resources :posts
  end
  
  resources :posts do
  	resources :comments
  end

  resources :comments do
  	resources :replies
  end



end
