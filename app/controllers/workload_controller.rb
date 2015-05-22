class WorkloadController < ApplicationController
  before_filter :authenticate_user!

  def index
    @uid = current_user.id
    @user = User.find(@uid)
    @draft_projects = current_user.draft_projects
    @preliminary_review_projects = current_user.preliminary_review_projects
    @pre_legal_review_projects = current_user.pre_legal_review_projects
    @regional_review_projects = current_user.regional_review_projects
    @secondary_review_projects = current_user.secondary_review_projects
    @cn_clearance_projects = current_user.cn_clearance_projects
    @funding_clearance_projects = current_user.funding_clearance_projects
    @obligation_projects = current_user.obligation_projects

    @new_cns = current_user.new_cns
    @internal_clearance_cns = current_user.internal_clearance_cns
    @congressional_clearance_cns = current_user.congressional_clearance_cns

    @funding_confirmation = current_user.funding_confirmation
    @funding_clearance = current_user.funding_clearance

    @my_projects = current_user.my_projects
  end


  def dashboard
  end

  def my_projects
    @my_projects = current_user.my_projects
  end

end
