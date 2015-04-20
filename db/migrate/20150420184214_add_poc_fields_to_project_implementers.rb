class AddPocFieldsToProjectImplementers < ActiveRecord::Migration
  def change
    add_column :project_implementers, :poc_name, :string
    add_column :project_implementers, :poc_email, :string
    add_column :project_implementers, :poc_phone, :string
    add_column :project_implementers, :poc_office, :string
  end
end
