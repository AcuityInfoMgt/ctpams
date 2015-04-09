class Project < ActiveRecord::Base
  include Workflow
  belongs_to :program
  belongs_to :user
  has_many :obligations
  accepts_nested_attributes_for :obligations, :reject_if => :all_blank, :allow_destroy => true
  has_many :cn_projects
  has_many :congressional_notifications, through: :cn_projects
  has_many :people, as: :personable
  accepts_nested_attributes_for :people, :reject_if => :all_blank, :allow_destroy => true
  has_many :comments, as: :commentable
  has_many :clearances, as: :clearable
  has_many :attached_files, as: :attachable
  accepts_nested_attributes_for :attached_files, :reject_if => :all_blank, :allow_destroy => true
  has_many :budget_items
  accepts_nested_attributes_for :budget_items, :reject_if => :all_blank, :allow_destroy => true
  has_many :project_implementers
  has_many :implementers, through:  :project_implementers
  has_many :project_funding_mechanisms
  has_many :funding_mechanisms, through: :project_funding_mechanisms
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :sub_accounts
  enum implementation_status: [:'Pre-Implementation', :'Active', :'Complete']
  after_initialize :set_defaults, :if => :new_record?

  workflow do
    state :'Proposal in Progress' do
      event :submit, :transitions_to => :'Preliminary Program Review'
    end
    state :'Preliminary Program Review' do
      event :send_to_legal, :transitions_to => :'Pre-Legal Review'
      event :request_changes, :transitions_to => :'Proposal in Progress'
      event :deny, :transitions_to => :Denied
    end
    state :'Pre-Legal Review' do
      event :send_to_program, :transitions_to => :'Preliminary Program Review'
      event :preclear_proposal, :transitions_to => :'Regional Review'
    end
    state :'Regional Review' do
      event :send_comments, :transitions_to => :'Secondary Program Review'
    end
    state :'Secondary Program Review' do
      event :approve, :transitions_to => :'CN Clearance Pending'
      event :deny, :transitions_to => :Denied
    end
    state :'CN Clearance Pending' do
      event :cn_cleared, :transitions_to => :'Funding Clearance Pending'
    end
    state :'Funding Clearance Pending' do
      event :clear_funding, :transitions_to => :'Obligation Pending'
    end
    state :'Obligation Pending' do
      event :obligate_all_funds, :transitions_to => :'Project Fully Obligated'
    end
    state :'Project Fully Obligated'
    state :Denied
  end



  def set_defaults
    self.implementation_status ||= :'Pre-Implementation'
    self.is_active ||= true
  end

end
