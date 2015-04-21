class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def show
    @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    @playlist = Playlist.find(params[:id])
    @songs = @playlist.list_all_uid
    @song = Song.new
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

  private
  def playlist_params
    params.require(:playlist).permit(:name, :host_id)
  end
end
