class Course < ActiveRecord::Base
  attr_accessible :building_id, :ccode, :end_time, :friday, :monday, :room, :saturday, :start_time, :sunday, :teacher, :term_id, :thursday, :tuesday, :type, :wednesday
end
