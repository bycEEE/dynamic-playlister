class Request < ActiveRecord::Base
  belongs_to :song
  belongs_to :playlist
  belongs_to :user

  def initialize 
    @up_voters = []
    @down_voters = []
  end

  def up_voters
    @up_voters
  end

  def add_up_voter(voter)
    @up_voters << voter
  end

  def down_voters
    @down_voters
  end

  def add_up_voter(voter)
    @down_voters << voter
  end
end
