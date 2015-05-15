class AddOnHoldToCongressionalNotifications < ActiveRecord::Migration
  def change
    add_column :congressional_notifications, :on_hold, :boolean
  end
end
