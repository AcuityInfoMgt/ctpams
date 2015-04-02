class CreateCountriesRegions < ActiveRecord::Migration
  def change
    create_table :countries_regions, :id => false do |t|
      t.integer :country_id
      t.integer :region_id
    end
  end
end
