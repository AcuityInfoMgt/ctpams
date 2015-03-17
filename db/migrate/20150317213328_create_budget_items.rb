class CreateBudgetItems < ActiveRecord::Migration
  def change
    create_table :budget_items do |t|
      t.string :name
      t.integer :budget_amount
      t.integer :project_id
      t.integer :budgetable_id
      t.string :budgetable_type

      t.timestamps null: false
    end

    add_index :budget_items, :budgetable_id

  end
end
