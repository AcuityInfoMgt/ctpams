class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :iso2
      t.string :iso3
      t.string :boundary_type
      t.text :boundary_coordinates
      t.integer :region_id

      t.timestamps null: false
    end
  end
end
