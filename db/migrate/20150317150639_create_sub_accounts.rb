class CreateSubAccounts < ActiveRecord::Migration
  def change
    create_table :sub_accounts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
