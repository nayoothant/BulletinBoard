Rails.application.routes.draw do
  #get 'login/login'
  resources :users do
    collection do
      post :create_confirm
      get :create_confirm, to: "users#new"
      get :search_user
    end
    member do
      get :profile, to: "users#profile"
      get :edit_profile, to: "users#edit_profile"
      patch :update_profile
      get :change_password
      post :update_password
    end
  end

  resources :posts do
    collection do
      post :post_create_confirm
      get :post_create_confirm, to: "posts#new"
      get :search_post
    end
    member do
      get :update_confirm, to: "posts#update_confirm"
      post :update_confirm
      post :update_post
    end
  end
  
  get 'users/new'
  get 'login', to: 'login#login'
  post 'login', to: 'login#userlogin'
  get 'logout', to: 'login#logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
