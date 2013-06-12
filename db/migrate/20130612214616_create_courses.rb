class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer   :term_id,         null: false

      t.integer   :course_name_id,  null: false

      t.integer   :ccode,           null: false

      t.string    :type,            null: false, default: 'LEC', limit: 3

      t.datetime  :start_time,      null: false
      t.datetime  :end_time,        null: false

      t.boolean   :monday,          null: false, default: false
      t.boolean   :tuesday,         null: false, default: false
      t.boolean   :wednesday,       null: false, default: false
      t.boolean   :thursday,        null: false, default: false
      t.boolean   :friday,          null: false, default: false
      t.boolean   :saturday,        null: false, default: false
      t.boolean   :sunday,          null: false, default: false

      t.string    :teacher,         null: false

      t.integer   :building_id,     null: false
      t.string    :room,            null: false

      t.string    :status

      t.timestamps
    end

    add_index :courses, :term_id
    add_index :courses, :course_name_id
    add_index :courses, :status

  end
end
