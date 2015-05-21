class User < ActiveRecord::Base
  has_many :projects
  has_and_belongs_to_many :programs
  has_and_belongs_to_many :regions
  has_many :comments
  enum role: [:submitter, :reviewer, :budget, :viewer, :admin, :legal, :regional, :foreign_assistance, :legislative_affairs, :policy_planning, :front_office]
  after_initialize :set_defaults, :if => :new_record?

  def set_defaults
    self.role ||= :submitter
    self.is_active ||= true
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :confirmable

  def in_project_region?(project_id)
    Project.where("id = (?)", project_id).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id).count > 0
    #true
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
    @projects = Project.includes(:program).where("user_id = (?) or id in (select personable_id from people where personable_type = 'Project' and email = (?))", self.id, self.email)
  end

  def get_proposal_in_progress
    if self.role == 'submitter'
      @projects = Project.includes(:program).with_draft_state.where(user_id: self.id)
    elsif self.role == 'reviewer'
        @projects = Project.includes(:program).with_draft_state.where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.includes(:program).with_draft_state
    end
  end

  def get_project_preliminary
    if self.role == 'reviewer'
      @projects = Project.includes(:program).with_preliminary_review_state.where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.includes(:program).with_preliminary_review_state
    end
  end

  def get_project_pre_legal
    if self.role == 'admin' || self.role == 'legal'
      @projects = Project.includes(:program).with_prelegal_review_state
    end
  end

  def get_project_regional
    if self.role == 'regional'
      @projects = Project.includes(:program).with_regional_review_state.where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.includes(:program).with_regional_review_state
    end
  end

  def get_project_secondary
    if self.role == 'reviewer'
      @projects = Project.includes(:program).with_secondary_review_state.where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.includes(:program).with_secondary_review_state
    end
  end

  def get_project_cn
    if self.role == 'reviewer'
      @projects = Project.includes(:program).with_cn_clearance_state.where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin' || self.role == 'budget'
      @projects = Project.includes(:program).with_cn_clearance_state
    end
  end

  def get_project_funding
    if self.role == 'admin' || self.role == 'budget'
      @projects = Project.includes(:program).with_funding_clearance_state
    end
  end

  def get_project_obligation
    if self.role == 'admin' || self.role == 'budget'
      @projects = Project.includes(:program).with_obligation_state
    end
  end

  def get_cn_new
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.with_new_state
    end
  end

  def get_cn_clearance
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.with_internal_clearance_state
    end
  end

  def get_cn_congress
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.with_congressional_clearance_state
    end
  end

  def get_cn_hold
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where("on_hold = true")
    end
  end

  def get_funding_confirmation
    if self.role == 'admin' || self.role == 'budget'
      @funding_mechanisms = ProjectFundingMechanism.includes(:project, :funding_mechanism).with_confirmation_pending_state.where(projects: { workflow_state: 'funding_clearance_pending' })
    end
  end

  def get_funding_clearance
    if self.role == 'admin' || self.role == 'budget'
      @funding_mechanisms = ProjectFundingMechanism.includes(:project, :funding_mechanism).with_clearance_pending_state
    end
  end

  def get_funding_hold
    if self.role == 'admin' || self.role == 'budget'
      @funding_mechanisms = ProjectFundingMechanism.includes(:project, :funding_mechanism).with_on_hold_state
    end
  end


end
