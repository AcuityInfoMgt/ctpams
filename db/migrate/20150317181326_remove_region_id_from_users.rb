class RemoveRegionIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :region_id, :integer
  end
end
