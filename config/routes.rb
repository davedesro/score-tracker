ScoreTracker::Application.routes.draw do

  # root to: :home

  resources :users, only: [ :new, :create ]

end
