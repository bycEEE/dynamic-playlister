class SubscriptionsController < ApplicationController
  # def new
  #   binding.pry
  #   render 
  # end

  def create
    playlist = Playlist.find(params[:subscription][:playlist_id])
    @subscription = Subscription.find_or_create_by( {
        :playlist_id => params[:subscription][:playlist_id],
        :subscriber_id => current_user.id,
        :approved => false
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

  def update
    subscription = Subscription.find(params[:subscription][:subscription_id])
    if subscription.approved == false
      subscription.approved = true
      subscription.save
    else 
      # remove subscription
      subscription.delete
      # subscription.approved = false
      # subscription.save
    end
    playlist = subscription.playlist
    redirect_to playlist
  end
end
