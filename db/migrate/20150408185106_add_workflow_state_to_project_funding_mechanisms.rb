class AddWorkflowStateToProjectFundingMechanisms < ActiveRecord::Migration
  def change
    add_column :project_funding_mechanisms, :workflow_state, :string
  end
end
