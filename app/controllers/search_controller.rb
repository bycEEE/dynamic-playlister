class SearchController < ApplicationController

	def youtube_search
    @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    search = @client.videos_by(:query => params[:search_field], :page => 1, :per_page => 20)
    @videos = search.videos
  end

end
