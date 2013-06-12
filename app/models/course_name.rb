class CourseName < ActiveRecord::Base
  attr_accessible :course_number, :department_id, :name, :term_id
end
