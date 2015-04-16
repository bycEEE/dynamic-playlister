class AddTwitterInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :nickname, :string
    add_column :users, :profile_image, :string
    add_column :users, :profile_url, :string
    add_column :users, :token, :string
    add_column :users, :secret, :string
  end
end
