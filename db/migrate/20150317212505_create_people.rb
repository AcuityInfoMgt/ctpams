class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :office
      t.integer :personable_id
      t.string :personable_type

      t.timestamps null: false
    end

    add_index :people, :personable_id
  end
end
