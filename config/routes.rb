Linkity::Application.routes.draw do
  devise_for :users

  resources :users
  resources :comments

  resources :posts do
    resource :vote
    resources :comments
  end
  
  root :to => "posts#index"
end
