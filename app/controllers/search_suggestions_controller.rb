class SearchSuggestionsController < ApplicationController
  def index
    @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    search = @client.videos_by(:query => params[:term], :page => 1, :per_page => 11)
    videos = search.videos
    videos.shift #removes youtube device support first link
    # videos = videos.each_with_object({}).with_index(1) do  |(video, video_hash), index|
    #   video_hash[index.to_s] = {}
    #   video_hash[index.to_s][:title] = video.title
    #   video_hash[index.to_s][:id] = video.unique_id
    # end

    # @titles = videos.each_with_object([]) { |video, titles| titles << video[1][:title] }
    # @ids = videos.each_with_object([]) { |video, ids| ids << video[1][:id] }
    videos = videos.each_with_object([]) do |video, videos_array|
      hash = {}
      hash[:label] = video.title
      hash[:value] = video.unique_id
      videos_array << hash
    end
    render json: videos
  end
end
