class Country < ActiveRecord::Base
  belongs_to :region
  has_and_belongs_to_many :projects
  has_many :budget_items, as: :budgetable
end
