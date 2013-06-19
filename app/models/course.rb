class Course < ActiveRecord::Base
  # attr_accessible :building_id, :ccode, :end_time, :friday, :monday, :room, 
  # :saturday, :start_time, :sunday, :teacher, :term_id, :thursday, :tuesday, :type, :wednesday

  belongs_to  :building
  belongs_to  :term
  belongs_to  :department

  belongs_to  :parent_course, class_name: 'Course'

  has_many    :child_courses, class_name: 'Course', foreign_key: 'parent_course_id'

  validates_presence_of   :term_id, :department_id
  validates_presence_of   :course_num, :name, :ccode, :section, :type

  def days=(new_days)
    self.monday     = !(new_days =~ /M/).nil?
    self.tuesday    = !(new_days =~ /Tu/).nil?
    self.wednesday  = !(new_days =~ /W/).nil?
    self.thursday   = !(new_days =~ /Th/).nil?
    self.friday     = !(new_days =~ /F/).nil?
    self.saturday   = !(new_days =~ /Sa/).nil?
    self.sunday     = !(new_days =~ /Su/).nil?
  end

  def days
    day_list.join
  end

  def day_list
    day_arr = []
    day_arr << 'M' if self.monday?
    day_arr << 'Tu' if self.tuesday?
    day_arr << 'W' if self.wednesday?
    day_arr << 'Th' if self.thursday?
    day_arr << 'F' if self.friday?
    day_arr << 'Sa' if self.saturday?
    day_arr << 'Su' if self.sunday?
    day_arr
  end

  def meeting_time
    self.start_time.strftime("%l:%M%P").strip + " - " + self.end_time.strftime("%l:%M%P").strip
  end

  def self.inheritance_column
    nil
  end

  def to_s
    "Course<##{self.id}><#{self.department.code}><#{self.course_num}><#{self.type}>[#{self.pretty_ccode}]"
  end

  def pretty_ccode
    "%05d" % self.ccode
  end

  def to_calendar_json
    cal_days = []

    self.day_list.each do |day|

      start_time_base = self.start_time.advance days: 2
      end_time_base = self.end_time.advance days: 2

      advance_amount = %w(M Tu W Th F Sa Su).index(day)
      
      cal_days << {
        id: "#{self.pretty_ccode}#{day.downcase}",
        groupId: self.pretty_ccode,
        title: "#{self.department.code} #{self.course_num} #{self.type}<br>(#{self.pretty_ccode})",
        start: start_time_base.advance(days: advance_amount),
        end: end_time_base.advance(days: advance_amount)
      }
    end

    cal_days
  end


end
