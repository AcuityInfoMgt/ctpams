class CreateCnProjects < ActiveRecord::Migration
  def change
    create_table :cn_projects do |t|
      t.integer :congressional_notification_id
      t.integer :project_id
      t.boolean :is_renotification

      t.timestamps null: false
    end
  end
end
