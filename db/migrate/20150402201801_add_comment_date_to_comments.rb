class AddCommentDateToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_date, :datetime
  end
end
