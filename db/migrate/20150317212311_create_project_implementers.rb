class CreateProjectImplementers < ActiveRecord::Migration
  def change
    create_table :project_implementers do |t|
      t.integer :project_id
      t.integer :implementer_id

      t.timestamps null: false
    end
  end
end
