class SearchController < ApplicationController

  def youtube_search
    Yt.configuration.api_key = ENV['YOUTUBE_KEY']
    # @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    videos = Yt::Collections::Videos.new
    search = videos.where(:q => params[:search_field], order: 'viewCount')
    @videos = search
  end

  def autocomplete
    Yt.configuration.api_key = ENV['YOUTUBE_KEY']
    # @client = YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_KEY'])
    videos = Yt::Collections::Videos.new
    search = videos.where(:q => params[:term], order: 'viewCount')
    # videos = search.videos
    # videos.shift #removes youtube device support first link
    search.first
    items = search.as_json["items"]
    videos = items.each_with_object([]) do |video, videos_array|
      hash = {}
      hash[:label] = video["snippet"]["data"]["title"]
      hash[:value] = video["id"]
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
