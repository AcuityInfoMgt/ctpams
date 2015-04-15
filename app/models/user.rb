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
    elsif self.role == 'admin'
      @projects = Project.where(workflow_state: 'proposal_in_progress')
    end
  end

  def get_preliminary_program_review
    if self.role == 'reviewer'
      @projects = Project.where(workflow_state: 'preliminary_program_review').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.where(workflow_state: 'preliminary_program_review')
    end
  end

  def get_pre_legal_review
    if self.role == 'admin' || self.role == 'legal'
      @projects = Project.where(workflow_state: 'pre_legal_review')
    end
  end

  def get_regional_review
    if self.role == 'regional'
      @projects = Project.where(workflow_state: 'regional_review').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.where(workflow_state: 'regional_review')
    end
  end

  def get_secondary_program_review
    if self.role == 'reviewer'
      @projects = Project.where(workflow_state: 'secondary_program_review').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin'
      @projects = Project.where(workflow_state: 'secondary_program_review')
    end
  end

  def get_cn_clearance_pending
    if self.role == 'reviewer'
      @projects = Project.where(workflow_state: 'cn_clearance_pending').where(program_id: self.programs).where("id in (select project_id from countries_projects where country_id in (select country_id from countries_regions where region_id in (select region_id from regions_users where user_id = (?))))", self.id)
    elsif self.role == 'admin' || self.role == 'budget'
      @projects = Project.where(workflow_state: 'cn_clearance_pending')
    end
  end

  def get_funding_clearance_pending
    if self.role == 'admin' || self.role == 'budget'
      @projects = Project.where(workflow_state: 'funding_clearance_pending')
    end
  end

  def get_obligation_pending
    if self.role == 'admin' || self.role == 'budget'
      @projects = Project.where(workflow_state: 'obligation_pending')
    end
  end

  def get_new_cn
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where(workflow_state: 'new')
    end
  end

  def get_clearance_pending_cn
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where(workflow_state: 'cn_clearance_pending')
    end
  end

  def get_congress_pending_cn
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where(workflow_state: 'cn_congressional_clearance_pending')
    end
  end

  def get_hold_cn
    if self.role == 'admin' || self.role == 'budget'
      @cns = CongressionalNotification.where(workflow_state: 'cn_on_hold')
    end
  end


end
