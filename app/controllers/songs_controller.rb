class SongsController < ApplicationController

  def create
    if params[:song][:url] =~ /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com(?:\/embed\/|\/v\/|\/watch\?v=|\/watch\?.+&v=))([\w-]{11})(?:.+)?$/
      song_hash = Song.get_song_hash_from_url(params[:song][:url])
      Song.find_or_create_by(song_hash)
    else
      redirect_to root_path
    end

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

  def show
    @song = Song.find(params[:id])
  end
end
