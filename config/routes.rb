Rails.application.routes.draw do
  
  root to: 'static_pages#index'

  get '/search_suggestions', to: 'search#autocomplete'

  post '/votes/upvote', to: 'votes#upvote'
  post '/votes/downvote', to: 'votes#downvote'
  post '/requests/destroy', to: 'requests#destroy'
  get '/playlists/:id/youtube_search', to: 'search#youtube_search'

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create', via: 'get'
  match '/auth/failure', to: redirect('/'), via: 'get'
  get 'logout', to: 'sessions#destroy'

  # Dashboard
  get '/dashboard', to: 'users#dashboard'

  # Tags
  get 'tags/:tag', to: 'playlists#index', as: :tag

  resources :votes
  resources :requests
  resources :songs
  resources :users
  
  resources :playlists do 
    resources :chat_messages
  end

  resources :playlists do
    resources :songs
  end

  # 


end