class Project < ActiveRecord::Base
  belongs_to :program
  belongs_to :user
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :sub_accounts
  enum implementation_status: [:preimplementation, :active, :complete]
  after_initialize :set_defaults, :if => :new_record?

  def set_defaults
    self.implementation_status ||= :preimplementation
    self.is_active ||= true
  end
end
