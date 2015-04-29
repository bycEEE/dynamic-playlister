class Request < ActiveRecord::Base
  belongs_to :song
  belongs_to :playlist
  belongs_to :listener, :class_name => "User"
  has_many :votes
end
