class AddIsArchivedToAttachedFiles < ActiveRecord::Migration
  def change
    add_column :attached_files, :is_archived, :boolean
  end
end
