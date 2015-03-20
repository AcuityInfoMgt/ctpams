class AddOldIdToImplementers < ActiveRecord::Migration
  def change
    add_column :implementers, :old_id, :integer
  end
end
