class AddWorkflowStateToCongressionalNotifications < ActiveRecord::Migration
  def change
    add_column :congressional_notifications, :workflow_state, :string
  end
end
