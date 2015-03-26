class ProjectFundingMechanism < ActiveRecord::Base
  belongs_to :project
  belongs_to :funding_mechanism
  has_one :person, as: :personable
  has_many :clearances, as: :clearable

end
