class AddVotesToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :votes, :integer, :default => 1
  end
end
