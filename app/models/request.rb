class Request < ActiveRecord::Base
  belongs_to :song
  belongs_to :playlist
  belongs_to :user

  attr_accessor :upvoters, :down_voters

  def initialize 
    @up_voters = []
    @up_voters = []
  end
end
