class AddAprovedtoSubscribers < ActiveRecord::Migration
  def change
    add_column :subscriptions, :approved, :boolean, :default => false
  end
end
