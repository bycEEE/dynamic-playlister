class SongsController < ApplicationController

  def create
    playlist = Playlist.find(params[:playlist_id])
    if params[:search_term_or_url] =~ /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com(?:\/embed\/|\/v\/|\/watch\?v=|\/watch\?.+&v=))([\w-]{11})(?:.+)?$/
      song_hash = Song.get_song_hash_from_url($1)
      song = Song.find_or_create_by(song_hash)
      request = Request.find_or_create_by(
      {   :song_id => song.id, 
          :listener_id => current_user.id,
          :playlist_id => playlist.id,
          :position => playlist.requests.last.position + 1 })
    else
      song_hash = Song.get_song_hash_from_url(params[:search_term_or_url])
      song = Song.find_or_create_by(song_hash)

      if playlist.requests.maximum("position")
        request = Request.find_or_create_by(
        {   :song_id => song.id, 
            :listener_id => current_user.id,
            :playlist_id => playlist.id,
            :position => playlist.requests.maximum("position") + 1 })
      else
        request = Request.find_or_create_by(
        {   :song_id => song.id, 
            :listener_id => current_user.id,
            :playlist_id => playlist.id,
            :position => 0 }) 
      end
    end
    broadcast_information = { :request_id => "#{request.id}", 
                              :name => "#{song.name}", 
                              :vote_count => "#{request.vote_count}", 
                              :song_id => "#{request.song_id}",
                              :uid => "#{song.uid}"}
    FayeServer.broadcast("/playlists/#{request.playlist_id}/add", broadcast_information)
    render :nothing => true
  end

  def show
    @song = Song.find(params[:id])
  end
end
