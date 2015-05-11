class ProjectFundingMechanism < ActiveRecord::Base
  include Workflow
  belongs_to :project
  belongs_to :funding_mechanism
  has_one :person, as: :personable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable

  workflow do
    state :confirmation_pending do
      event :confirm_funding_mechanism, :transitions_to => :clearance_pending
    end
    state :clearance_pending do
      event :clear, :transitions_to => :cleared
      event :hold, :transitions_to => :on_hold
    end
    state :on_hold   do
      event :reactivate, :transitions_to => :confirmation_pending
    end
    state :cleared
  end

end
