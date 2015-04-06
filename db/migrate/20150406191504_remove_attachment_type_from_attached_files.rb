class RemoveAttachmentTypeFromAttachedFiles < ActiveRecord::Migration
  def change
    remove_column :attached_files, :attachment_type, :integer
  end
end
