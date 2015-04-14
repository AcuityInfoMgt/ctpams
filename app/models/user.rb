class User < ActiveRecord::Base
  has_many :projects
  has_and_belongs_to_many :programs
  has_and_belongs_to_many :regions
  has_many :comments
  enum role: [:submitter, :reviewer, :budget, :viewer, :admin, :legal, :regional, :commenter, :fclear, :hclear, :spclear, :foclear]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :submitter
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :confirmable

  def get_proposal_in_progress
    if self.role == 'submitter'
      @projects = Project.where(workflow_state: 'proposal_in_progress').where(user_id: self.id)
    elsif self.role == 'reviewer'
        @projects = Project.where(workflow_state: 'proposal_in_progress').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'budget'
      @projects = Project.where(workflow_state: 'proposal_in_progress')
    end
  end

  def get_preliminary_program_review
    #@role = self.role
    if self.role = :admin
      @projects = Project.where(workflow_state: 'preliminary_program_review')
    else
      nil
    end

  end

  def get_pre_legal_review
    #@role = self.role
    @projects = Project.where(workflow_state: 'pre_legal_review')
  end

  def get_regional_review
    #@role = self.role
    @projects = Project.where(workflow_state: 'regional_review')
  end

  def get_secondary_program_review
    #@role = self.role
    @projects = Project.where(workflow_state: 'secondary_program_review')
  end

  def get_cn_clearance_pending
    #@role = self.role
    @projects = Project.where(workflow_state: 'cn_clearance_pending')
  end

  def get_funding_clearance_pending
    #@role = self.role
    @projects = Project.where(workflow_state: 'funding_clearance_pending')
  end

  def get_obligation_pending
    #@role = self.role
    @projects = Project.where(workflow_state: 'obligation_pending')
  end


end
