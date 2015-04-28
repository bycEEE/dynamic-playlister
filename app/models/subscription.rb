class Subscription < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :subscriber, class_name: "User"#, :foreign_key => 'host_id'

  validates_uniqueness_of :subscriber_id, :scope => [:playlist_id]
end
