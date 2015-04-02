class AddRegionTypeToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :region_type, :integer
  end
end
