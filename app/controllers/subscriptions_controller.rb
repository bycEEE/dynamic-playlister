class SubscriptionsController < ApplicationController
  # def new
  #   binding.pry
  #   render 
  # end

  def create
    playlist = Playlist.find(params[:subscription][:playlist_id])
    @subscription = Subscription.find_or_create_by( {
        :playlist_id => params[:subscription][:playlist_id],
        :subscriber_id => current_user.id
      } )
    redirect_to playlist
    # redirect_to "playlists/#{params[:subscription][:playlist_id]}"
    # binding.pry
  end

  def destroy
    playlist = Playlist.find(params[:subscription][:playlist_id])
    @subscription = Subscription.find_by( {
        :playlist_id => params[:subscription][:playlist_id],
        :subscriber_id => current_user.id
      } ).delete
    redirect_to playlist
    # redirect_to "playlists/#{params[:subscription][:playlist_id]}"
  end
end
