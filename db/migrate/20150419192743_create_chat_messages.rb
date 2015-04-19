class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
    	t.string :content
    	t.integer :playlist_id
    	t.integer :user_id
      t.timestamps null: false
    end
  end
end
