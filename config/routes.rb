Ratebeer::Application.routes.draw do
  resources :styles
  resources :memberships do
    post 'confirm', :on => :member
  end
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries do
    post 'toggle_activity', :on => :member
  end
  root :to => 'breweries#index'
  resources :ratings, :only => [:index, :new, :create, :destroy]
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get "places/:city/:id" => "places#show", as: :place
  get 'places' => 'places#index'
  post "places" => "places#search"  
  delete 'signout', to: 'sessions#destroy'
  resources :sessions, :only => [:new, :create, :destroy]
  get 'beerlist' => 'beers#list'
end
