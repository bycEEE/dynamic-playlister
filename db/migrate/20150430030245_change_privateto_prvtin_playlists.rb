class ChangePrivatetoPrvtinPlaylists < ActiveRecord::Migration
  def change
    rename_column :playlists, :private, :prvt
  end
end
