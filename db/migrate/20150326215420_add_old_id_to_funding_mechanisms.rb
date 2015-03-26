class AddOldIdToFundingMechanisms < ActiveRecord::Migration
  def change
    add_column :funding_mechanisms, :old_id, :integer
  end
end
