Ratebeer::Application.routes.draw do
  resources :memberships


  resources :beer_clubs


  resources :users
  resources :beers
  resources :breweries
  root :to => 'breweries#index'
  resources :ratings, :only => [:index, :new, :create, :destroy]
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resources :sessions, :only => [:new, :create, :destroy]
end
