class PlaylistsController < ApplicationController
  def index
    if params[:tag]
      @playlists = Playlist.tagged_with(params[:tag])
      @tag = params[:tag]
    else
      @playlists = Playlist.all
    end
  end

  def show
    @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    @playlist = Playlist.find(params[:id])
    @songs = @playlist.list_all_uid
    @song = Song.new
    @subscription = Subscription.find_by({:playlist_id => @playlist.id, :subscriber_id => current_user.id })
    @approved_subscriptions = @playlist.subscriptions.where(:approved => true) 
    @unapproved_subscriptions = @playlist.subscriptions.where(:approved => false)
    @like = Like.find_by({:playlist_id => @playlist.id, :user_id => current_user.id })

    if @playlist.prvt && current_user.id != @playlist.host_id
      flash[:notice] = "This playlist is private!."
      redirect_to current_user
    end
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = current_user.host_playlists.build(playlist_params)
    if @playlist.save
      redirect_to @playlist
    else
      render :new
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])

    if @playlist.host_id != current_user.id
      flash[:notice] = "You can't edit another user's playlist."
      redirect_to @playlist
    end
  end

  def update
    flash[:notice] = []
    @playlist = Playlist.find(params[:id])
    if @playlist.locked == true && playlist_params[:locked] == "0"
        flash[:notice] << "Playlist successfully unlocked"
    elsif @playlist.locked == false && playlist_params[:locked] == "1"
      flash[:notice] << "Playlist successfully locked"
    end
    if @playlist.prvt == true && playlist_params[:prvt] == "0"
      flash[:notice] << "Playlist successfully made public"
    elsif @playlist.prvt == false && playlist_params[:prvt] == "1"
      flash[:notice] << "Playlist successfully made private"
    end
    if playlist_params[:tag_list] != @playlist.tag_list.join(", ")
      flash[:notice] << "Tags successfully updated"
    end
    @playlist.update_attributes(playlist_params)
      redirect_to @playlist
  end

  private
  def playlist_params
    params.require(:playlist).permit(:name, :host_id, :locked, :tag_list, :prvt)
  end

end
