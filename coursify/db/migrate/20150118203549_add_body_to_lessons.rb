class AddBodyToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :body, :text
  end
end
