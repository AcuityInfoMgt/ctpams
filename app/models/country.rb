class Country < ActiveRecord::Base
  belongs_to :region
  has_and_belongs_to_many :projects
end
