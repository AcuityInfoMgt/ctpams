class Implementer < ActiveRecord::Base
  has_many :project_implementers
  has_many :projects, through:  :project_implementers
  has_many :budget_items, as: :budgetable
end
