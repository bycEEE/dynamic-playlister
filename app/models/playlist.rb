class Playlist < ActiveRecord::Base
  has_many :requests
  has_many :songs, through: :requests
  belongs_to :host, :class_name => "User"
  has_many :chat_messages

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions

  validates_uniqueness_of :host_id, :scope => "name"
  #implement dependent destroy for requests

  # taggable gem:
  acts_as_taggable

  def list_all_uid
    requests.order(:position).each_with_object([]) { |request, songs_array| songs_array << "\'#{request.song.uid}\'"}.join(",") 
  end

  def update_position(video_id_array)
    requests.each_with_index do |request, index|
      # request.position = video_id_array.index(request.song.uid)
      request.update(position: video_id_array.index(request.song.uid))
    end
  end
end
