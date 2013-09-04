Ratebeer::Application.routes.draw do
  resources :beers
  resources :breweries
  root :to => 'breweries#index'
  resources :ratings, :only => [:index, :new, :create, :destroy]
end
