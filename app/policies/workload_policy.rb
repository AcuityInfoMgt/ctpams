class WorkloadPolicy < Struct.new(:user, :workload)
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    #@current_user.admin?
    true
    #@current_user.role == 'admin'
    #false
  end



end