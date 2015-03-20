class AddOldIdToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :old_id, :integer
  end
end
