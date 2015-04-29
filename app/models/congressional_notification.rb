class CongressionalNotification < ActiveRecord::Base
  include Workflow
  has_and_belongs_to_many :projects
  has_many :comments, as: :commentable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable

  workflow do
    state :new do
      event :submit_cn, :transitions_to => :cn_clearance_pending
    end
    state :cn_clearance_pending do
      event :clear, :transitions_to => :cn_congressional_clearance_pending
      event :hold, :transitions_to => :cn_on_hold
      event :deny, :transitions_to => :cn_denied
    end
    state :cn_congressional_clearance_pending do
      event :clear, :transitions_to => :cn_cleared
      event :hold, :transitions_to => :cn_on_hold
      event :deny, :transitions_to => :cn_denied
    end
    state :cn_on_hold   do
      event :reactivate, :transitions_to => :cn_clearance_pending
      event :deny, :transitions_to => :cn_denied
    end
    state :cn_cleared
    state :cn_denied
  end
end
