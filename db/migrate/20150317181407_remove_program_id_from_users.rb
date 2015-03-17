class RemoveProgramIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :program_id, :integer
  end
end
