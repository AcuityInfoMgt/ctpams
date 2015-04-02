class Country < ActiveRecord::Base
  has_and_belongs_to_many :regions
  has_and_belongs_to_many :projects
  has_many :budget_items, as: :budgetable
end
