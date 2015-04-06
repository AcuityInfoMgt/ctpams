class CreateAttachedFiles < ActiveRecord::Migration
  def change
    create_table :attached_files do |t|
      t.integer :attachment_type
      t.string :name
      t.boolean :is_active
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps null: false
    end
  end
end
