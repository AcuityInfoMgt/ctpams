class RemoveIsModificationFromFundingMechanisms < ActiveRecord::Migration
  def change
    remove_column :funding_mechanisms, :is_modification, :boolean
  end
end
