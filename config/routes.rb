Rails.application.routes.draw do
  resources :requests

  root to: 'static_pages#index'
  resources :playlists
  resources :songs

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create', via: 'get'
  match '/auth/failure', to: redirect('/'), via: 'get'
  get 'logout', to: 'sessions#destroy'
end
