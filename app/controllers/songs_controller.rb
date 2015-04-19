class SongsController < ApplicationController

	def create
  	song = Song.find_or_create_by(Song.get_song_hash_from_url(params[:song][:url]))
  	request = Request.find_or_create_by(
  	{	:song_id => song.id, 
  		:listener_id => params[:song][:user_id], 
  		:playlist_id => params[:song][:playlist_id] })
  	playlist = Playlist.find(params[:song][:playlist_id])
  	redirect_to playlist
  end

end
