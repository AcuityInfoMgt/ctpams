class AddOldIdToSubAccounts < ActiveRecord::Migration
  def change
    add_column :sub_accounts, :old_id, :integer
  end
end
