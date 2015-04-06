class ProjectFundingMechanism < ActiveRecord::Base
  belongs_to :project
  belongs_to :funding_mechanism
  has_one :person, as: :personable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable

end
