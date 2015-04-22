class SearchController < ApplicationController

  def youtube_search
    @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    search = @client.videos_by(:query => params[:search_field], :page => 1, :per_page => 20)
    @videos = search.videos
  end

  def autocomplete
    @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    search = @client.videos_by(:query => params[:term], :page => 1, :per_page => 11)
    videos = search.videos
    videos.shift #removes youtube device support first link

    videos = videos.each_with_object([]) do |video, videos_array|
      hash = {}
      hash[:label] = video.title
      hash[:value] = video.unique_id
      videos_array << hash
    end
    render json: videos
  end
end
