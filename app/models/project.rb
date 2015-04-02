class Project < ActiveRecord::Base
  belongs_to :program
  belongs_to :user
  has_many :obligations
  has_many :cn_projects
  has_many :congressional_notifications, through: :cn_projects
  has_many :people, as: :personable
  has_many :clearances, as: :clearable
  has_many :budget_items
  has_many :project_implementers
  has_many :implementers, through:  :project_implementers
  has_many :project_funding_mechanisms
  has_many :funding_mechanisms, through: :project_funding_mechanisms
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :sub_accounts
  enum implementation_status: [:'Pre-Implementation', :'Active', :'Complete']
  after_initialize :set_defaults, :if => :new_record?

  def set_defaults
    self.implementation_status ||= :preimplementation
    self.is_active ||= true
  end
end
