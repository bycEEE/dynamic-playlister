class VotesController < ApplicationController
  def upvote
    request = Request.find(params[:request_id])
    vote_hash = { :request_id => request.id, :user_id => current_user.id, :up_or_down => "upvote" }
    vote = Vote.find_by(vote_hash)
    if vote
      vote.destroy
      request.vote_count = request.vote_count - 1
      request.save
    else
      vote = Vote.create(vote_hash)
      request.vote_count = request.vote_count + 1
      request.save
    end
    broadcast_information = { :votes => "#{request.vote_count}", :request_id => "#{request.id}" }
    FayeServer.broadcast("/playlists/#{request.playlist.id}/votes", broadcast_information)
    render :nothing => true
  end

  def downvote
    request = Request.find(params[:request_id])
    vote_hash = { :request_id => request.id, :user_id => current_user.id, :up_or_down => "downvote" }
    vote = Vote.find_by(vote_hash)
    if vote
      vote.destroy
      request.vote_count = request.vote_count + 1
      request.save
    else
      vote = Vote.create(vote_hash)
      request.vote_count = request.vote_count - 1
      request.save
    end
    broadcast_information = { :votes => "#{request.vote_count}", :request_id => "#{request.id}" }
    FayeServer.broadcast("/playlists/#{request.playlist.id}/votes", broadcast_information)
    render :nothing => true
  end
end
