ScoreTracker::Application.routes.draw do

  root to: 'users#new' # TODO: change this once we have a real home page

  resources :users, only: [ :new, :create ]
  resource :user, only: [ :edit, :update ]
  resources :sessions, only: [ :new, :create, :destroy ]

  match '/signup',  to: 'users#new',        via: :get
  match '/signin',  to: 'sessions#new',     via: :get
  match '/signout', to: 'sessions#destroy', via: :delete

end
