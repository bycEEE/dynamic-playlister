class RequestsController < ApplicationController
  def upvote
    request = Request.find(params[:request_id])
    binding.pry
    if !(request.up_voters.include?(current_user.id))
      request.votes = request.votes + 1
      request.add_upvoter(current_user.id)
      request.save
      broadcast_information = { :votes => "#{request.votes}", :request_id => "#{request.id}" }
      Temp.broadcast("/playlists/#{request.playlist.id}/votes", broadcast_information)
    end
    binding.pry
    render :nothing => true
  end

  def downvote
    request = Request.find(params[:request_id])
    request.votes = request.votes - 1
    request.save
    broadcast_information = { :votes => "#{request.votes}", :request_id => "#{request.id}" }
    Temp.broadcast("/playlists/#{request.playlist.id}/votes", broadcast_information)
    render :nothing => true
  end
end
