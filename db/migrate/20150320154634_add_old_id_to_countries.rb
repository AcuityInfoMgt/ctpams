class AddOldIdToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :old_id, :integer
  end
end
