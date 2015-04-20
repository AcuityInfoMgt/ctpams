class ProjectImplementer < ActiveRecord::Base
  belongs_to :project
  belongs_to :implementer
end
