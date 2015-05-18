class Song < ActiveRecord::Base
  has_many :requests
  has_many :users, through: :requests
  has_many :playlists, through: :requests

  def self.get_song_hash_from_url(videoid)
    Yt.configuration.api_key = ENV['YOUTUBE_KEY']
    # client = YouTubeIt::Client.new(:dev_key => ENV["YOUTUBE_KEY"])
    video = Yt::Video.new id: videoid
    # binding.pry
    song_hash = {
      :name => video.title,
      :url => "https://www.youtube.com/watch?v=" + videoid,
      :uid => videoid
      }
    song_hash
  end
end
