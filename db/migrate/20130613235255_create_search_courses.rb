class CreateSearchCourses < ActiveRecord::Migration
  def change
    create_table :search_courses do |t|
      t.integer :search_id,       null: false
      t.integer :department_id,   null: false
      t.string  :course_num,      null: false
    end
    add_index :search_courses, :search_id
  end
end
