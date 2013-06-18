class PossibleSchedule

  def initialize(search, classes)
    @classes = classes
    @search = search
  end

  def ccodes
    @classes.map(&:ccode)
  end

  def classes
    @classes
  end

  def has_time_collisions?
    temp_days = {}
    %w(M Tu W Th F Sa Su).each do |day|
      temp_days[day] = []
      temp_days[day].fill false, 0, 145
    end

    @classes.each do |course|

      start_time = (course.start_time.to_i - course.start_time.beginning_of_day.to_i) / 600
      end_time = (course.end_time.to_i - course.end_time.beginning_of_day.to_i) / 600

      course.day_list.each do |day|

        (start_time...end_time).each do |i|
          return true if temp_days[day][i]
        end

        (start_time...end_time).each do |i|
          temp_days[day][i] = true
        end

      end # /daylist
    end # /courses
    false
  end

  def valid?

    # Required sections
    if @search.req_sections.size > 0
      return false if (@search.req_sections & self.ccodes).size == 0
    end

    # Required statuses
    unless @search.status_list.nil?
      return false if (@classes.map(&:status) - @search.status_list).size > 0
    end

    # Required days
    if @search.days.size > 0
      return false if (@classes.map(&:day_list).flatten - @search.days).size > 0
    end

    # Start time
    if @search.start_time
      return false if @classes.select {|c| c.start_time < @search.start_time}.size > 0
    end

    # end time
    if @search.end_time
      return false if @classes.select {|c| c.end_time > @search.end_time}.size > 0
    end

    !self.has_time_collisions?
  end

end