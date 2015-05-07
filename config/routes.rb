Rails.application.routes.draw do
  root :to => redirect('/ingredients')
  resources :ingredients
end