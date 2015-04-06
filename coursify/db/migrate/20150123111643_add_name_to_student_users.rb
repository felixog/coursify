class AddNameToStudentUsers < ActiveRecord::Migration
  def up
    add_column :student_users, :name, :string
  end

  def down
  	remove_column :student_users, :name, :string
  end
end
