class AddObligtionCommentsToObligations < ActiveRecord::Migration
  def change
    add_column :obligations, :obligation_comments, :string
  end
end
