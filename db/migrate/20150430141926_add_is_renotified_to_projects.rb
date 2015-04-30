class AddIsRenotifiedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :is_renotified, :boolean
  end
end
