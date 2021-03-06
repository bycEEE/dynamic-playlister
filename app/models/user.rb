class User < ActiveRecord::Base
  has_many :host_playlists, :class_name => "Playlist", :foreign_key => 'host_id'
  has_many :requests, :foreign_key => 'listener_id'
  has_many :listener_playlists, -> { uniq }, through: :requests, :source => :playlist
  has_many :songs, through: :requests, :foreign_key => 'listener_id'
  has_many :chat_messages
  has_many :votes
  
  has_many :subscriptions, :foreign_key => 'subscriber_id'
  has_many :playlists, :through => :subscriptions

  has_many :likes
  has_many :liked_playlists, :through => :likes, :source => :playlist

  def twitter
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end
  end

  def filter_listener_playlist
    #self.listener_playlist.select where host id != listender_id
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      name: auth_hash.info.name,
      nickname: auth_hash.info.nickname,
      profile_image: auth_hash.info.image,
      profile_url: auth_hash.info.urls.Twitter,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
      )
    user
  end
end
