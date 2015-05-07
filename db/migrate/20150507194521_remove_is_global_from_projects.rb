class RemoveIsGlobalFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :is_global, :boolean
  end
end
