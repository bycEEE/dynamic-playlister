Rails.application.routes.draw do
  
  resources :votes

  get '/search_suggestions', to: 'search#autocomplete'

  root to: 'static_pages#index'
  
  resources :playlists do 
    resources :chat_messages
  end

  resources :playlists do
    resources :songs
  end
  resources :requests
  resources :songs

  post '/votes/upvote', to: 'votes#upvote'
  post '/votes/downvote', to: 'votes#downvote'
  post '/requests/destroy', to: 'requests#destroy'

  resources :users #Limit resources

  get '/playlists/:id/youtube_search', to: 'search#youtube_search'

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create', via: 'get'
  match '/auth/failure', to: redirect('/'), via: 'get'
  get 'logout', to: 'sessions#destroy'
end