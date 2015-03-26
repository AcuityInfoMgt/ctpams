class RemoveProjectIdFromFundingMechanisms < ActiveRecord::Migration
  def change
    remove_column :funding_mechanisms, :project_id, :integer
  end
end
