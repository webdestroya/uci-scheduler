class SearchCourse < ActiveRecord::Base
  # attr_accessible :course_num, :department_id, :search_id
  belongs_to  :search
  belongs_to  :department


  def to_s
    parts = []

    parts << self.department.code if self.department
    parts << "#{self.course_num}:" if self.course_num

    if self.department && self.course_num
      crs = Course.where(department_id: self.department_id)
        .where(course_num: self.course_num)
        .where(term_id: self.search.term.id).first

      parts << crs.name if crs
    end

    parts.join ' '
  end

end
