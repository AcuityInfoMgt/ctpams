class CreateCongressionalNotifications < ActiveRecord::Migration
  def change
    create_table :congressional_notifications do |t|
      t.string :name
      t.string :cn_number

      t.timestamps null: false
    end
  end
end
