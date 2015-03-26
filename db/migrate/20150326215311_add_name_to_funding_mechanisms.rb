class AddNameToFundingMechanisms < ActiveRecord::Migration
  def change
    add_column :funding_mechanisms, :name, :string
  end
end
