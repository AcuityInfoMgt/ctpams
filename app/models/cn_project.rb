class CnProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :congressional_notification
  after_initialize :set_defaults, :if => :new_record?


  def set_defaults
    self.is_renotification ||= false
  end
end
