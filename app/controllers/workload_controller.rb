class WorkloadController < ApplicationController
  before_filter :authenticate_user!

  def index
    @uid = current_user.id
    @user = User.find(@uid)
    @proposal_in_progress = current_user.get_proposal_in_progress
    @preliminary_program_review = current_user.get_preliminary_program_review
    @pre_legal_review = current_user.get_pre_legal_review
    @regional_review = current_user.get_regional_review
    @secondary_program_review = current_user.get_secondary_program_review
    @cn_clearance_pending = current_user.get_cn_clearance_pending
    @funding_clearance_pending = current_user.get_funding_clearance_pending
    @obligation_pending = current_user.get_obligation_pending
  end

  def cn
    @uid = current_user.id
    @user = User.find(@uid)
    @cn_new = current_user.get_new_cn
    @cn_clearance_pending = current_user.get_clearance_pending_cn
    @cn_congress_pending = current_user.get_congress_pending_cn
    @cn_hold = current_user.get_hold_cn
  end

  def dashboard
  end
end
