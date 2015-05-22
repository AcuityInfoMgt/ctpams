class ProjectFundingMechanism < ActiveRecord::Base
  include Workflow
  belongs_to :project
  belongs_to :funding_mechanism
  has_one :person, as: :personable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable

  workflow do
    state :funding_confirmation do
      event :confirm_funding_mechanism, :transitions_to => :funding_clearance
    end
    state :funding_clearance do
      event :clear, :transitions_to => :cleared
    end
    state :cleared
  end

end
