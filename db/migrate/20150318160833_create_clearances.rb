class CreateClearances < ActiveRecord::Migration
  def change
    create_table :clearances do |t|
      t.string :name
      t.integer :clearance_status
      t.date :clearance_date
      t.text :comments
      t.integer :clearable_id
      t.string :clearable_type

      t.timestamps null: false
    end
  end
end
