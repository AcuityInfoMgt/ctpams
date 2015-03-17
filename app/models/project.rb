class Project < ActiveRecord::Base
  enum implementation_status: [:preimplementation, :active, :complete]
  after_initialize :set_defaults, :if => :new_record?

  def set_defaults
    self.implementation_status ||= :preimplementation
    self.is_active ||= true
  end
end
