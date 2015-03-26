class CreateProjectFundingMechanisms < ActiveRecord::Migration
  def change
    create_table :project_funding_mechanisms do |t|
      t.integer :project_id
      t.integer :funding_mechanism_id

      t.timestamps null: false
    end
  end
end
