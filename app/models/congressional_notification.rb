class CongressionalNotification < ActiveRecord::Base
  has_many :cn_projects
  has_many :projects, through: :cn_projects
end
