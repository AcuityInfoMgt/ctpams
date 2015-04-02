class RemoveRegionIdFromCountries < ActiveRecord::Migration
  def change
    remove_column :countries, :region_id, :integer
  end
end
