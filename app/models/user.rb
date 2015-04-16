class User < ActiveRecord::Base
  has_many :playlists, :foreign_key => 'host_id'
  has_many :requests, :foreign_key => 'listener_id'
  has_many :playlists, through: :requests, :foreign_key => 'listener_id'
  has_many :songs, through: :requests, :foreign_key => 'listener_id'
end
