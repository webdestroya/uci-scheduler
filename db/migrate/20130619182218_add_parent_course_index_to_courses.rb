class AddParentCourseIndexToCourses < ActiveRecord::Migration
  def change
    add_index :courses, :parent_course_id
  end
end
