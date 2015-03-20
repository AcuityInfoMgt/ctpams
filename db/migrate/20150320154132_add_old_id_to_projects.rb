class AddOldIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :old_id, :integer
  end
end
