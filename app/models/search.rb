class Search < ActiveRecord::Base
  # attr_accessible :courses_list, :end_time, :friday, :monday, :saturday, :start_time, 
  # :statuses, :sunday, :term_id, :thursday, :tuesday, :wednesday

  # store :courses_list, accessors: [:crs_list]

  belongs_to  :term

  has_many :search_courses, dependent: :destroy
  accepts_nested_attributes_for :search_courses, reject_if: proc {|a| a['course_num'].blank?}

  def days
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

  def days=(daylist)
    self.monday = self.tuesday = self.wednesday = self.thursday = self.friday = self.saturday = self.sunday = false
    daylist.each do |day|
      self.monday = true if day.eql?('M')
      self.tuesday = true if day.eql?('Tu')
      self.wednesday = true if day.eql?('W')
      self.thursday = true if day.eql?('Th')
      self.friday = true if day.eql?('F')
      self.saturday = true if day.eql?('Sa')
      self.sunday = true if day.eql?('Su')
    end
  end

  def earliest_time=(time)
    self.start_time = Chronic.parse(time)
  end

  def latest_time=(time)
    self.end_time = Chronic.parse(time)
  end

  def earliest_time
    self.start_time.strftime('%l:%M%P').strip
  end

  def latest_time
    self.end_time.strftime('%l:%M%P').strip
  end

  def status_list
    return nil if self.statuses.nil?
    self.statuses.split(',')
  end

  def status_list=(statuslist)
    self.statuses = statuslist.join(',')
  end



  # def search_courses
  #   test = SearchCourse.new
  #   test.dept = 5
  #   [
  #     test, test
  #   ]
  # end

  # def search_course_attributes=(attrs)
  #   puts attrs.inspect
  # end

  def self.day_list
    [
      ['M', 'Mon'],
      ['Tu', 'Tues'],
      ['W', 'Wed'],
      ['Th', 'Thurs'],
      ['F', 'Fri'],
      ['Sa', 'Sat'],
      ['Su', 'Sun'],
    ]
  end

  def self.status_list
    %w(OPEN Waitl FULL NewOnly)
  end

end
