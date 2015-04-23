class RequestsController < ApplicationController
  def upvote
    request = Request.find(params[:request_id])
    request.votes = request.votes + 1
    request.save
    broadcast_information = { :votes => "#{request.votes}", :request_id => "#{request.id}" }
    FayeServer.broadcast("/playlists/#{request.playlist.id}/votes", broadcast_information)
    render :nothing => true
  end

  def downvote
    request = Request.find(params[:request_id])
    request.votes = request.votes - 1
    request.save
    broadcast_information = { :votes => "#{request.votes}", :request_id => "#{request.id}" }
    FayeServer.broadcast("/playlists/#{request.playlist.id}/votes", broadcast_information)
    render :nothing => true
  end

  def destroy
    request = Request.find(params[:request_id])
    broadcast_information = { :request_id => "#{request.id}" }
    request.destroy
    FayeServer.broadcast("/playlists/#{request.playlist.id}/delete", broadcast_information)
    render :nothing => true
  end
end
