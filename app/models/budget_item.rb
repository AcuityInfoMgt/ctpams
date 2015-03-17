class BudgetItem < ActiveRecord::Base
  belongs_to :project
  belongs_to :budgetable, polymorphic: true
end
