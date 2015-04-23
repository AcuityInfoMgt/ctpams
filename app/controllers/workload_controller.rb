class WorkloadController < ApplicationController
  before_filter :authenticate_user!

  def index
    @uid = current_user.id
    @user = User.find(@uid)
    @proposal_in_progress = current_user.get_proposal_in_progress
    @preliminary_program_review = current_user.get_project_preliminary
    @pre_legal_review = current_user.get_project_pre_legal
    @regional_review = current_user.get_project_regional
    @secondary_program_review = current_user.get_project_secondary
    @project_cn_pending = current_user.get_project_cn
    @project_funding_clearance_pending = current_user.get_project_funding
    @obligation_pending = current_user.get_project_obligation

    @cn_new = current_user.get_cn_new
    @cn_clearance_pending = current_user.get_cn_clearance
    @cn_congress_pending = current_user.get_cn_congress
    @cn_hold = current_user.get_cn_hold

    @funding_confirmation_pending = current_user.get_funding_confirmation
    @funding_clearance_pending = current_user.get_funding_clearance
    @funding_hold = current_user.get_funding_hold

    @my_projects = current_user.get_my_projects
  end


  def dashboard
  end

  def my_projects
  end

end
