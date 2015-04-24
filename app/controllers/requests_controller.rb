class RequestsController < ApplicationController
  def destroy
    request = Request.find(params[:request_id])
    broadcast_information = { :request_id => "#{request.id}", :request_song_uid => "#{request.song.uid}" }
    request.destroy
    FayeServer.broadcast("/playlists/#{request.playlist.id}/delete", broadcast_information)
    render :nothing => true
  end

  def arrange
    video_ids = params[:video_ids]
    playlist = Playlist.find(params[:playlist_id])
    playlist.update_position(video_ids)
    render :nothing => true
  end
end
