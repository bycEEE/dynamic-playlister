class Song < ActiveRecord::Base
  has_many :requests
end
