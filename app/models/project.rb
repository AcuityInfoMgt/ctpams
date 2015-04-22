class Project < ActiveRecord::Base
  validates :name, presence: true
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
  accepts_nested_attributes_for :project_implementers, :reject_if => :all_blank, :allow_destroy => true
  has_many :implementers, through:  :project_implementers
  has_many :project_funding_mechanisms
  accepts_nested_attributes_for :project_funding_mechanisms, :reject_if => :all_blank, :allow_destroy => true
  has_many :funding_mechanisms, through: :project_funding_mechanisms
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :sub_accounts
  enum implementation_status: [:'Pre-Implementation', :'Active', :'Complete']
  after_initialize :set_defaults, :if => :new_record?

  workflow do
    state :proposal_in_progress do
      event :submit, :transitions_to => :preliminary_program_review
    end
    state :preliminary_program_review do
      event :send_to_legal, :transitions_to => :pre_legal_review
      event :request_changes, :transitions_to => :proposal_in_progress
      event :deny, :transitions_to => :proposal_denied
    end
    state :pre_legal_review do
      event :send_to_program, :transitions_to => :preliminary_program_review
      event :preclear_proposal, :transitions_to => :regional_review
    end
    state :regional_review do
      event :send_comments, :transitions_to => :secondary_program_review
    end
    state :secondary_program_review do
      event :approve, :transitions_to => :cn_clearance_pending
      event :deny, :transitions_to => :proposal_denied
    end
    state :cn_clearance_pending do
      event :cn_cleared, :transitions_to => :funding_clearance_pending
    end
    state :funding_clearance_pending do
      event :clear_funding, :transitions_to => :obligation_pending
    end
    state :obligation_pending do
      event :obligate_all_funds, :transitions_to => :project_fully_obligated
    end
    state :project_fully_obligated
    state :proposal_denied
  end



  def set_defaults
    self.implementation_status ||= :'Pre-Implementation'
    self.is_active ||= true
    self.is_archived ||= false
    self.is_denied ||= false
    self.reprogram ||= false
  end

end
