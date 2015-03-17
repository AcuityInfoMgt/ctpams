class CreateProjectsSubAccounts < ActiveRecord::Migration
  def change
    create_table :projects_sub_accounts, :id => false do |t|
      t.integer :project_id
      t.integer :sub_account_id
    end
  end
end
