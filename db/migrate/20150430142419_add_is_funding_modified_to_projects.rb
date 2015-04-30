class AddIsFundingModifiedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :is_funding_modified, :boolean
  end
end
