class Playlist < ActiveRecord::Base
  has_many :requests
  has_many :songs, through: :requests
  belongs_to :host, :class_name => "User"

  has_many :chat_messages

  def list_all_uid
    songs.each_with_object([]) { |song, songs_array| songs_array << "\'#{song.uid}\'"}.join(",") 
  end
end
