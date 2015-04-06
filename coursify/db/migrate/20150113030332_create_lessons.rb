class CreateLessons < ActiveRecord::Migration  
  def up
    create_table :lessons do |t|
	  t.integer "section_id"
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :default => false

      t.timestamps
    end
    add_index("lessons", "section_id")
    add_index("lessons", "permalink")

  end

  def down
  	drop_table :lessons
  end
end
