class AddDescriptionToProjectImplementer < ActiveRecord::Migration
  def change
    add_column :project_implementers, :description, :string
  end
end
