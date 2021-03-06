class Region < ActiveRecord::Base
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :users
  enum region_type: [:State, :RSI]
end
