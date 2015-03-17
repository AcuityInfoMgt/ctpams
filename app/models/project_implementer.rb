class ProjectImplementer < ActiveRecord::Base
  has_one :person, as: :personable
  belongs_to :project
  belongs_to :implementer
end
