class CreateFundingMechanisms < ActiveRecord::Migration
  def change
    create_table :funding_mechanisms do |t|
      t.integer :funding_type
      t.boolean :is_modification
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
