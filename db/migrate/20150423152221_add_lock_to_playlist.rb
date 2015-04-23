class AddLockToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :locked, :boolean, :default => false
  end
end
