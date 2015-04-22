class SongsController < ApplicationController

  def create
    playlist = Playlist.find(params[:playlist_id])
    if params[:search_term_or_url] =~ /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com(?:\/embed\/|\/v\/|\/watch\?v=|\/watch\?.+&v=))([\w-]{11})(?:.+)?$/
      song_hash = Song.get_song_hash_from_url($1)
      song = Song.find_or_create_by(song_hash)
      request = Request.find_or_create_by(
      {   :song_id => song.id, 
          :listener_id => current_user.id,
          :playlist_id => playlist.id })
    else
      song_hash = Song.get_song_hash_from_url(params[:search_term_or_url])
      song = Song.find_or_create_by(song_hash)
      request = Request.find_or_create_by(
      {   :song_id => song.id, 
          :listener_id => current_user.id,
          :playlist_id => playlist.id })
    end
    render json: song
  end

  def show
    @song = Song.find(params[:id])
  end
end
