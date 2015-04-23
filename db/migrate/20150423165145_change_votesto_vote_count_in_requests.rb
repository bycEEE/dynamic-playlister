class ChangeVotestoVoteCountInRequests < ActiveRecord::Migration
  def change
    rename_column :requests, :votes, :vote_count
  end
end
