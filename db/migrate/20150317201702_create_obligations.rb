class CreateObligations < ActiveRecord::Migration
  def change
    create_table :obligations do |t|
      t.string :obligation_number
      t.integer :obligation_amount
      t.date :obligation_date
      t.integer :fiscal_year
      t.string :comments
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
