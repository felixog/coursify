class AddNameToAdminUsers < ActiveRecord::Migration
  def up
    add_column :admin_users, :name, :string
  end

  def down
  	remove_column :admin_users, :name, :string
  end
end