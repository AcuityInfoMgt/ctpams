class User < ActiveRecord::Base
  has_many :projects
  has_and_belongs_to_many :programs
  has_and_belongs_to_many :regions
  enum role: [:submitter, :reviewer, :budget, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :submitter
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
