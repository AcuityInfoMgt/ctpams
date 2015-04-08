class WorkloadController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @projects = current_user.get_project_workload
  end

  def dashboard
  end
end
