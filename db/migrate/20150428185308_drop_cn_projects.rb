class DropCnProjects < ActiveRecord::Migration
  def change
    drop_table :cn_projects
  end
end
