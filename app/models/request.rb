class Request < ActiveRecord::Base
  belongs_to :song
  belongs_to :playlist
  belongs_to :user
  has_many :votes
end
