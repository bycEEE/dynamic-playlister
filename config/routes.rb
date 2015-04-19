Rails.application.routes.draw do
  
  root to: 'static_pages#index'
  
  resources :playlists do 
  	resources :chat_messages
  end

  resources :requests
  resources :songs

  get 'youtube_search', to: 'playlists#youtube_search'

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create', via: 'get'
  match '/auth/failure', to: redirect('/'), via: 'get'
  get 'logout', to: 'sessions#destroy'
end
