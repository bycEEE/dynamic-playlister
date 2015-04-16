class Playlist < ActiveRecord::Base
  has_many :requests
  has_many :songs, through: :requests
  belongs_to :host, :class_name => "User"
end
