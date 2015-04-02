class AddAbbreviationToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :abbreviation, :string
  end
end
