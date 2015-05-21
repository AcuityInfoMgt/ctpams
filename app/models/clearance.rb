class Clearance < ActiveRecord::Base
  belongs_to :clearable, polymorphic: true
  enum clearance_status: [:'Not Set', :'Pending', :'Yes', :'No']
  after_initialize :set_default_clearance_status, :if => :new_record?

  def set_default_clearance_status
    self.clearance_status ||= :'Not Set'
  end
end
