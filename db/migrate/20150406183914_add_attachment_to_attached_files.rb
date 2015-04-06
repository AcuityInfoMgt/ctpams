class AddAttachmentToAttachedFiles < ActiveRecord::Migration
  def self.up
    add_attachment :attached_files, :attachable_document
  end

  def self.down
    remove_attachment :attached_files, :attachable_document
  end
end
