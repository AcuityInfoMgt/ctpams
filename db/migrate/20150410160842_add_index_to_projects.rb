class AddIndexToProjects < ActiveRecord::Migration
  def change
    add_index :projects, :workflow_state
  end
end
