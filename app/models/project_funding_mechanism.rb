class ProjectFundingMechanism < ActiveRecord::Base
  include Workflow
  belongs_to :project
  belongs_to :funding_mechanism
  has_one :person, as: :personable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable

  workflow do
    state :new do
      event :confirm_funding_mechanism, :transitions_to => :funding_clearance_pending
    end
    state :funding_clearance_pending do
      event :clear, :transitions_to => :funding_cleared
      event :hold, :transitions_to => :funding_on_hold
      event :deny, :transitions_to => :funding_denied
    end
    state :funding_on_hold   do
      event :reactivate, :transitions_to => :confirm_funding_mechanism
      event :deny, :transitions_to => :funding_denied
    end
    state :funding_cleared
    state :funding_denied
  end

end
