class AddDoRenotifyToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :do_renotify, :boolean
  end
end
