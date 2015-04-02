class FundingMechanism < ActiveRecord::Base
  has_many :project_funding_mechanisms
  has_many :projects, through:  :project_funding_mechanisms
  has_many :comments, as: :commentable
end
