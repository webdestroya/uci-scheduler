class SearchCourse < ActiveRecord::Base
  # attr_accessible :course_num, :department_id, :search_id
  belongs_to  :search
  belongs_to  :department


  # Get a list of the various section types for this course
  # (LEC, DIS, LAB, etc)
  def course_types
    @course_types ||= Course.where(department_id: self.department_id)
      .where(course_num: self.course_num)
      .where(term_id: self.search.term_id)
      .select(:type)
      .map(&:type)
      .uniq
  end

  # Get a list of all possible combinations of this course
  def schedules



    main_courses = Course.where(department_id: self.department_id)
      .where(course_num: self.course_num)
      .where(term_id: self.search.term_id)
      .where(parent_course_id: nil)
      .includes(:child_courses)

    # Loop thru the main courses (the LEC )
    sched_list = main_courses.collect do |course|
      # This is a single section course, so just bail out
      return [course] if course.child_courses.empty?
      
      types = {}
      self.course_types.each do |type|
        types[type] = [] unless type == course.type
      end

      course.child_courses.each do |crs|
        types[crs.type] << crs
      end

      [course].product(*types.values)
    end

    sched_list.flatten(1)
  end


  def to_s
    parts = []

    parts << self.department.code if self.department
    parts << "#{self.course_num}" if self.course_num

    if self.department && self.course_num && self.search
      crs = Course.where(department_id: self.department_id)
        .where(course_num: self.course_num)
        .where(term_id: self.search.term_id).first

      parts << crs.name if crs
    end

    parts.join ' '
  end

end
