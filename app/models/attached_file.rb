class AttachedFile < ActiveRecord::Base
  has_attached_file :attachable_document
  validates_with AttachmentPresenceValidator, :attributes => :attachable_document
  validates_attachment_file_name :attachable_document, :matches => [/ods\Z/, /odt\Z/, /pdf\Z/]
  #validates_with AttachmentSizeValidator, :attributes => :attachable_document, :less_than => 1.megabytes
  belongs_to :attachable, polymorphic: true
  after_initialize :set_defaults, :if => :new_record?

  def set_defaults
    self.is_active ||= true
  end

end
