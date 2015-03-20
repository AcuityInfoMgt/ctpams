class AddOldIdToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :old_id, :integer
  end
end
