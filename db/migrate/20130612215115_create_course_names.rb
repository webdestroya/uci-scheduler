class CreateCourseNames < ActiveRecord::Migration
  def change
    create_table :course_names do |t|
      t.integer :term_id,         null: false
      t.integer :department_id,   null: false
      t.string  :course_number,   null: false
      t.string  :name,            null: false

      t.timestamps
    end

    add_index :course_names, :term_id
    add_index :course_names, [:department_id, :course_number]

  end
end
