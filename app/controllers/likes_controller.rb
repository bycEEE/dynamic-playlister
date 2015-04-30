class LikesController < ApplicationController
  def create
    like = Like.create(like_params)
    flash[:notice] = "You've liked this playlist."
    redirect_to Playlist.find(params[:like][:playlist_id])
  end

  def destroy
    like = Like.find_by(like_params)
    like.destroy
    flash[:notice] = "You've unliked this playlist."
    redirect_to Playlist.find(params[:like][:playlist_id])
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :playlist_id)
  end
end
