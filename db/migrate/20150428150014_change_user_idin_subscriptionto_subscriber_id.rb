class ChangeUserIdinSubscriptiontoSubscriberId < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :user_id, :subscriber_id
  end
end
