Rails.application.routes.draw do
  root :to => 'categories#index'
  resources :categories, :only => [:show]
  resources :recipes

  resource :user, :except => [:destroy] do
    post :forgot
    get :recover
    put :reset
    patch :reset
  end

  get :login, :to => 'user_sessions#new'
  post :login, :to => 'user_sessions#create'
  scope 'login/google', :controller => :user_google_sessions do
    root :action => :new, :via => [:get], :as => :google_login
    get :auth, :action => :create, :as => :google_authenticate
  end
  delete :logout, :to => 'user_sessions#destroy'
end