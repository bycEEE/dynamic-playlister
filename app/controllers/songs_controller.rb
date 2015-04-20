class SongsController < ApplicationController

  def create
    playlist_id = params[:song][:playlist_id] || params[:playlist_id]
    song_hash = Song.get_song_hash_from_url(params[:song][:url])
    song = Song.find_or_create_by(song_hash)
    request = Request.find_or_create_by(
    {  :song_id => song.id, 
        :listener_id => current_user.id, 
        :playlist_id => playlist_id })
    playlist = Playlist.find(playlist_id)
    
    if params[:playlist_id]
      # broadcast() - broadcast logic
      render :nothing
    else
      redirect_to playlist
    end
  end
end
