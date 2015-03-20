class AddOldIdToCongressionalNotifications < ActiveRecord::Migration
  def change
    add_column :congressional_notifications, :old_id, :integer
  end
end
