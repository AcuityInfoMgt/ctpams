class FundingMechanism < ActiveRecord::Base
  belongs_to :project
  has_one :person, as: :personable
  has_many :clearances, as: :clearable
  enum funding_type: [:'Bureau Transfer', :'Contract', :'Cooperative Agreement', :'Fund cite to post', :'Grant', :'MOU/IAA']
  after_initialize :set_default_type, :if => :new_record?

  def set_default_type
    self.funding_type ||= :'Bureau Transfer'
  end
end
