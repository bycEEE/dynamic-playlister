class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :song_id
      t.integer :listener_id
      t.integer :playlist_id
    end
  end
end
