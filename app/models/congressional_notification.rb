class CongressionalNotification < ActiveRecord::Base
  include Workflow
  has_and_belongs_to_many :projects
  has_many :comments, as: :commentable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable

  workflow do
    state :new do
      event :submit_cn, :transitions_to => :clearance_pending
    end
    state :clearance_pending do
      event :clear, :transitions_to => :congressional_clearance_pending
      event :hold, :transitions_to => :on_hold
    end
    state :congressional_clearance_pending do
      event :clear, :transitions_to => :cleared
      event :hold, :transitions_to => :on_hold
    end
    state :on_hold   do
      event :reactivate, :transitions_to => :clearance_pending
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

end
