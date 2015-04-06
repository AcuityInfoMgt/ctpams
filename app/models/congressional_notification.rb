class CongressionalNotification < ActiveRecord::Base
  has_many :cn_projects
  has_many :projects, through: :cn_projects
  has_many :comments, as: :commentable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable
end
