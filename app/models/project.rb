class Project < ActiveRecord::Base

  def self.default_scope
    where is_denied: false, is_archived: false, is_active: true
  end

  validates :name, presence: true
  validates :program, presence: true

  include Workflow
  attr_accessor :new_comments
  belongs_to :program
  belongs_to :user
  has_many :obligations
  accepts_nested_attributes_for :obligations, :reject_if => :all_blank, :allow_destroy => true
  has_and_belongs_to_many :congressional_notifications
  has_many :people, as: :personable
  accepts_nested_attributes_for :people, :reject_if => :all_blank, :allow_destroy => true
  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments, :reject_if => :all_blank, :allow_destroy => true
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
    state :draft do
      event :submit, :transitions_to => :regional_review
    end
    state :regional_review do
      event :send_comments, :transitions_to => :preliminary_review
    end
    state :preliminary_review do
      event :send_to_legal, :transitions_to => :prelegal_review
      event :request_changes, :transitions_to => :draft
    end
    state :prelegal_review do
      event :send_to_program, :transitions_to => :preliminary_review
      event :preclear_proposal, :transitions_to => :secondary_review
    end
    state :secondary_review do
      event :approve, :transitions_to => :cn_clearance
      event :request_changes, :transitions_to => :draft
    end
    state :cn_clearance do
      event :cn_cleared, :transitions_to => :funding_clearance
    end
    state :funding_clearance do
      event :clear_funding, :transitions_to => :obligation
    end
    state :obligation do
      event :obligate_all_funds, :transitions_to => :fully_obligated
    end
    state :fully_obligated
  end

  def set_defaults
    self.implementation_status ||= :'Pre-Implementation'
    self.is_active ||= true
    self.is_archived ||= false
    self.is_denied ||= false
    self.reprogram ||= false
    self.do_renotify ||= false
    self.is_renotified ||= false
    self.is_funding_modified ||= false
  end

  def update_project_state(state_event, comments, commenter)
    if comments && comments.strip.length > 0
      c = Comment.create(comments: comments, user_id: commenter, comment_date: DateTime.now)
      c.commentable = self
      c.save
    end

    if state_event == 'Save and Submit for Review'
      self.submit!
      'Proposal was successfully submitted for review.'
    elsif state_event == 'Send Comments to Program'
      self.send_comments!
    elsif state_event == 'Send to Legal (skip Regional Review)'
      self.send_comments!
      self.send_to_legal!
      'Proposal was sent to Legal for Pre-Clear.'
    elsif state_event == 'Send to Legal'
      self.send_to_legal!
      'Proposal was sent to Legal for Pre-Clear.'
    elsif state_event == 'Request Changes'
      self.request_changes!
      'Proposal was sent to Submitter for Changes.'
    elsif state_event == 'Send to Program'
      self.send_to_program!
      'Proposal sent back to Program.'
    elsif state_event == 'Pre-Clear Proposal'
      self.preclear_proposal!
      'Proposal Pre-Cleared Successfully.'
    elsif state_event == 'Approve Proposal'
      self.approve!
      'Proposal Successfully Approved.'
    elsif comments && comments.strip.length > 0
      'Comments Added'
    else
      'Project Updated'
    end
  end

  def self.filter(attributes)
    projects = Project.includes(:program).order(:id)
    projects = projects.where('fiscal_year in (?)', attributes[:fiscal_year]) if attributes[:fiscal_year].present?
    projects = projects.where('program_id in (?)', attributes[:program_id]) if attributes[:program_id].present?
    projects = projects.where('projects.id in (select project_id from project_funding_mechanisms where funding_mechanism_id in (?))', attributes[:funding_mechanism_id]) if attributes[:funding_mechanism_id].present?
    projects = projects.where('projects.id in (select project_id from projects_sub_accounts where sub_account_id in (?))', attributes[:sub_account_id]) if attributes[:sub_account_id].present?
    projects = projects.where('projects.id in (select project_id from countries_projects where country_id in (?))', attributes[:country_id]) if attributes[:country_id].present?
    projects = projects.where('projects.id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (?)))', attributes[:region_id]) if attributes[:region_id].present?
    projects = projects.where('projects.id in (select project_id from project_implementers where implementer_id in (?))', attributes[:implementer_id]) if attributes[:implementer_id].present?
    projects = projects.where('workflow_state in (?)', attributes[:workflow_state]) if attributes[:workflow_state].present?
    projects = projects.where('implementation_status in (?)', attributes[:implementation_status]) if attributes[:implementation_status].present?
    projects
  end

end
