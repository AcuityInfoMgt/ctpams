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
end
