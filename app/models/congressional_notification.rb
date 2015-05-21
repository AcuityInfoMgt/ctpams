class CongressionalNotification < ActiveRecord::Base
  include Workflow
  has_and_belongs_to_many :projects
  has_many :comments, as: :commentable
  has_many :clearances, as: :clearable
  accepts_nested_attributes_for :clearances, :reject_if => :all_blank, :allow_destroy => true
  has_many :attached_files, as: :attachable

  after_initialize :set_defaults, :if => :new_record?

  workflow do
    state :new do
      event :submit_cn, :transitions_to => :internal_clearance
    end
    state :internal_clearance do
      event :clear, :transitions_to => :congressional_clearance
    end
    state :congressional_clearance do
      event :clear, :transitions_to => :cleared
    end
    state :cleared
  end

  def update_cn_state(state_event, comments, commenter)
    if comments && comments.strip.length > 0
      c = Comment.create(comments: comments, user_id: commenter, comment_date: DateTime.now)
      c.commentable = self
      c.save
    end

    if state_event == 'Begin CN Clearance'
      self.submit_cn!
      'CN ready to be cleared.'
    elsif state_event == 'Confirm CN Clearance'
      self.clear!
      'CN clearance confirmed.'
    elsif state_event == 'Confirm Congressional Clearance'
      self.clear!
      'CN congressional clearance confirmed.'
    elsif comments && comments.strip.length > 0
      'Comments Added'
    else
      'Project Updated'
    end
  end

  def all_clearances_passed?
    all_clear = true
    self.clearances.each do |c|
      all_clear = false unless c.clearance_status == 'Yes'
    end
    all_clear
  end


  def create_cn_clearances
    c = Clearance.create(name: 'CT Coordinator')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Legal')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Foreign Assistance')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Legislative Affairs')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Policy Planning')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Management and Budget')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Deputy Review')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Front Office')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Foreign Assistance Front Office')
    c.clearable = self
    c.save
    c = Clearance.create(name: 'Legislative Affairs Front Office')
    c.clearable = self
    c.save
  end

  def self.filter(attributes)
    cns = CongressionalNotification.includes(:projects).order(:id)
    cns = cns.where('workflow_state in (?)', attributes[:workflow_state]) if attributes[:workflow_state].present?
    cns
  end

  def set_defaults
    self.on_hold ||= false
  end

end
