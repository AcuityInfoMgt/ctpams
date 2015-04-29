class CreateCongressionalNotificationsProjects < ActiveRecord::Migration
  def change
    create_table :congressional_notifications_projects, :id => false do |t|
      t.integer :congressional_notification_id
      t.integer :project_id
    end
  end
end
