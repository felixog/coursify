class CreateSections < ActiveRecord::Migration
  def up
    create_table :sections do |t|
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps
    end
  end

  def down
  	drop_table :sections
  end
end
