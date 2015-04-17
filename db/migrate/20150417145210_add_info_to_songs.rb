class AddInfoToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :url, :string
    add_column :songs, :uid, :string
  end
end
