class Song < ActiveRecord::Base
  has_many :requests
  has_many :users, through: :requests
  has_many :playlists, through: :requests

  def self.get_song_hash_from_url(videoid)
    client = YouTubeIt::Client.new(:dev_key => ENV["YOUTUBE_KEY"])
    video = client.video_by(videoid)
    song_hash = {
      :name => video.title,
      :url => video.media_content.first.url,
      :uid => videoid
      }
    song_hash
  end
end
