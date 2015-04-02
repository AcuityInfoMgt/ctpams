class RemoveCommentsFromObligations < ActiveRecord::Migration
  def change
    remove_column :obligations, :comments, :string
  end
end
