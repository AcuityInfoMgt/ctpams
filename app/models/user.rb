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

  def in_project_region?(project_id)
    Project.where("id = (?)", @project.id).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id).count > 0
  end

  def project_owner?(project_id)
    @project = Project.find(project_id)
    if self.id == @project.user_id
      true
    else
      Project.where("id = (?)", @project.id).where("id in (select personable_id from people where personable_type = 'Project' and email = (?))", self.email).count > 0
    end
  end

  # Workload Summary Queries:
  def get_my_projects
    @projects = Project.where("user_id = (?) or id in (select personable_id from people where personable_type = 'Project' and email = (?))", self.id, self.email)
  end

  def get_proposal_in_progress
    if self.role == 'submitter'
      @projects = Project.where(workflow_state: 'proposal_in_progress').where(user_id: self.id)
    elsif self.role == 'reviewer'
        @projects = Project.where(workflow_state: 'proposal_in_progress').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.where(workflow_state: 'proposal_in_progress')
    end
  end

  def get_project_preliminary
    if self.role == 'reviewer'
      @projects = Project.where(workflow_state: 'preliminary_program_review').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.where(workflow_state: 'preliminary_program_review')
    end
  end

  def get_project_pre_legal
    if self.role == 'admin' || self.role == 'legal'
      @projects = Project.where(workflow_state: 'pre_legal_review')
    end
  end

  def get_project_regional
    if self.role == 'regional'
      @projects = Project.where(workflow_state: 'regional_review').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.where(workflow_state: 'regional_review')
    end
  end

  def get_project_secondary
    if self.role == 'reviewer'
      @projects = Project.where(workflow_state: 'secondary_program_review').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.where(workflow_state: 'secondary_program_review')
    end
  end

  def get_project_cn
    if self.role == 'reviewer'
      @projects = Project.where(workflow_state: 'cn_clearance_pending').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin' || self.role == 'budget'
      @projects = Project.where(workflow_state: 'cn_clearance_pending')
    end
  end

  def get_project_funding
    if self.role == 'admin' || self.role == 'budget'
      @projects = Project.where(workflow_state: 'funding_clearance_pending')
    end
  end

  def get_project_obligation
    if self.role == 'admin' || self.role == 'budget'
      @projects = Project.where(workflow_state: 'obligation_pending')
    end
  end

  def get_cn_new
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where(workflow_state: 'new')
    end
  end

  def get_cn_clearance
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where(workflow_state: 'cn_clearance_pending')
    end
  end

  def get_cn_congress
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where(workflow_state: 'cn_congressional_clearance_pending')
    end
  end

  def get_cn_hold
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where(workflow_state: 'cn_on_hold')
    end
  end

  def get_funding_confirmation
    if self.role == 'admin' || self.role == 'budget'
      @funding_mechanisms = ProjectFundingMechanism.includes(:project, :funding_mechanism).where(workflow_state: 'funding_mechanism_confirmation_pending').where(projects: { workflow_state: 'funding_clearance_pending' })
    end
  end

  def get_funding_clearance
    if self.role == 'admin' || self.role == 'budget'
      @funding_mechanisms = ProjectFundingMechanism.includes(:project, :funding_mechanism).where(workflow_state: 'funding_clearance_pending')
    end
  end

  def get_funding_hold
    if self.role == 'admin' || self.role == 'budget'
      @funding_mechanisms = ProjectFundingMechanism.includes(:project, :funding_mechanism).where(workflow_state: 'funding_on_hold')
    end
  end


end
