class AddLastViewedLectureToStudentUsers < ActiveRecord::Migration
  def change
    add_column :student_users, :last_viewed_lecture, :string
  end
end
