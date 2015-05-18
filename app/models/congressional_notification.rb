class CongressionalNotification < ActiveRecord::Base
  include Workflow
  has_and_belongs_to_many :projects
  has_many :comments, as: :commentable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable

  after_initialize :set_defaults, :if => :new_record?

  workflow do
    state :new do
      event :submit_cn, :transitions_to => :clearance_pending
    end
    state :clearance_pending do
      event :clear, :transitions_to => :congressional_clearance_pending
    end
    state :congressional_clearance_pending do
      event :clear, :transitions_to => :cleared
    end
    state :cleared
  end


  def create_cn_clearances
    c = Clearance.create(name: 'CT', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Legal', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Foreign Assistance', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Legislative Affairs', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Policy Planning', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Management and Budget', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Deputy Review', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Front Office', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Foreign Assistance Front Office', clearance_status: 0)
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Legislative Affairs Front Office', clearance_status: 0)
    c.clearable = self
    c.save
  end

  def self.filter(attributes)
    cns = CongressionalNotification.includes(:projects).order(:id)
    cns = cns.where('workflow_state in (?)', attributes[:workflow_state]) if attributes[:workflow_state].present?
    cns
  end

  def set_defaults
    self.on_hold ||= false
  end

end
