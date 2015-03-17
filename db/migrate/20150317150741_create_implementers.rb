class CreateImplementers < ActiveRecord::Migration
  def change
    create_table :implementers do |t|
      t.string :name
      t.string :short_name
      t.string :parent_organization

      t.timestamps null: false
    end
  end
end
