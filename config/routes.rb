Rails.application.routes.draw do
  root :to => redirect('/ingredients')
  resources :ingredients

  scope :login, :controller => :user_sessions do
    root :action => :new, :via => [:get], :as => :login
    get :auth, :action => :create, :as => :authenticate
  end
end