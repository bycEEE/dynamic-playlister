class Song < ActiveRecord::Base
  has_many :requests
  has_many :users, through: :requests
  has_many :playlists, through: :requests

  def self.get_song_hash_from_url(url)
  	client = YouTubeIt::Client.new(:dev_key => ENV["YOUTUBE_KEY"])
  	video = client.video_by(url)
  	uid_match = video.media_content.first.url.match(/^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i)
  	uid = uid_match[2] if uid_match && uid_match[2]
  	song_hash = {
  		:name => video.title,
  		:url => video.media_content.first.url,
  		:uid => uid
  	}
  	song_hash
  end
end
