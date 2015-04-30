class AddIsGlobalToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :is_global, :boolean
  end
end
