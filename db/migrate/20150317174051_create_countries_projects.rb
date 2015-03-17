class CreateCountriesProjects < ActiveRecord::Migration
  def change
    create_table :countries_projects, :id => false do |t|
      t.integer :country_id
      t.integer :project_id
    end
  end
end
