class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def show
    @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    @playlist = Playlist.find(params[:id])

    @song = Song.new
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.create(playlist_params)
    redirect_to @playlist
  end

  def youtube_search
    @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    search = @client.videos_by(:query => params[:search_field], :page => 1, :per_page => 20)
    @videos = search.videos
  end

  private
  def playlist_params
    params.require(:playlist).permit(:name)
end
end
