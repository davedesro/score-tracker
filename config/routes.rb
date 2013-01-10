ScoreTracker::Application.routes.draw do

  root to: 'users#index' # TODO: change this once we have a real home page

  resource :user, only: [ :edit, :update ]
  resources :users, only: [ :index, :show ]
  resources :teams

  match '/signout', to: 'sessions#destroy', via: :delete

  match "/auth/google_oauth2/callback" => "google_sessions#login"
  match "/auth/failure" => "google_sessions#error"
end
