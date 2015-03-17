class Region < ActiveRecord::Base
  has_many :countries
  has_and_belongs_to_many :users
end
