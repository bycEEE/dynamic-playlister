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

  def playlist_search #via tags
    search = Playlist.find_by_name(params[:keyword])
    if search
      redirect_to "/playlists/#{search.id}"
    else
      @playlists = {}
      keywords = params[:keyword].split(/,\s*/)
      @playlists[:exact_tag_matches] = Playlist.tagged_with(keywords, :match_all => true)

      @playlists[:fuzzy_title_matches] = []
      keywords.each do |keyword|
        results = Playlist.where("name LIKE ?", "%#{keyword.downcase}%") 
        results.each do |result|
          @playlists[:fuzzy_title_matches] << result unless @playlists[:exact_tag_matches].include?(result)
        end
      end

      @playlists[:fuzzy_tag_matches] = []
      Playlist.tagged_with(keywords, :any => true).each do |result|
        @playlists[:fuzzy_tag_matches] << result unless @playlists[:exact_tag_matches].include?(result) || @playlists[:fuzzy_title_matches].include?(result)
      end
    end
  end
end
