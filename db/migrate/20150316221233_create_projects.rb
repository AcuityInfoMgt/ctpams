class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :budget_requested
      t.integer :fiscal_year
      t.text :objective
      t.text :interest
      t.text :law_enforcement
      t.text :coordination
      t.text :lessons_learned
      t.text :sustainability
      t.string :city_province
      t.string :program_audience
      t.boolean :reprogram
      t.text :reprogram_comments
      t.integer :implementation_status
      t.integer :program_id
      t.integer :user_id
      t.boolean :is_archived
      t.boolean :is_denied
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
