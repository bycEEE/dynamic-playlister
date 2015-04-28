class Subscription < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :subscriber, class_name: "User"#, :foreign_key => 'host_id'
end
