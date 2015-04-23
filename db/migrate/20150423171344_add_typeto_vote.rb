class AddTypetoVote < ActiveRecord::Migration
  def change
    add_column :votes, :up_or_down, :string
  end
end
