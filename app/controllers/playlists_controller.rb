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
    # broadcast_information = { :votes => "#{request.vote_count}", :request_id => "#{request.id}" }
    # FayeServer.broadcast("/playlists/#{request.playlist.id}/votes", broadcast_information)
  end

  def new
    @playlist = Playlist.new
  end

  def create
    binding.pry
    @playlist = current_user.host_playlists.build(playlist_params)
    if @playlist.save
      redirect_to @playlist
    else
      render :new
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])

    if @playlist.update_attributes(playlist_params)
      flash[:notice] = "Playlist successfully updated"
      redirect_to @playlist
    end
  end

  private
  def playlist_params
    params.require(:playlist).permit(:name, :host_id, :locked, :tag_list, :private)
  end

end
