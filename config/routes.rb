Rails.application.routes.draw do
  #get 'login/login'
  resources :users do
    collection do
      post :create_confirm
      get :create_confirm, to: "user#new"
      get :search_user
    end
    member do
      get :profile, to: "users#profile"
      get :edit_profile, to: "users#edit_profile"
      patch :update_profile
      get :change_password
    end
  end
  get 'users/new'
  get 'login', to: 'login#login'
  post 'login', to: 'login#userlogin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
