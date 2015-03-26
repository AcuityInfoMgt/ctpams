class RemoveFundingTypeFromFundingMechanisms < ActiveRecord::Migration
  def change
    remove_column :funding_mechanisms, :funding_type, :integer
  end
end
