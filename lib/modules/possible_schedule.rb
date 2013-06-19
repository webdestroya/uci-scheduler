class PossibleSchedule

  def initialize(search, classes)
    @classes = classes
    @search = search
  end

  def ccodes
    @ccodes ||= @classes.map(&:ccode)
  end

  def pretty_ccodes
    @pretty_ccodes ||= self.classes.map(&:pretty_ccode)
  end

  def classes
    @classes
  end

  def teachers
    @teachers ||= @classes.map(&:teacher).uniq.reject{|t|t.eql?('STAFF')}.sort
  end

  def statuses
    @statuses ||= @classes.map(&:status).uniq.sort
  end

  def has_full?
    self.has_status? "FULL"
  end

  def has_newonly?
    self.has_status? "NewOnly"
  end

  def has_waitlist?
    self.has_status? "Waitl"
  end

  def has_status?(status)
    self.statuses.include? status
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

  # This calculates a ranking of how good this schedule is
  # We can then sort the schedules based on this ranking
  def calc_ranking
    points = [0.0]
    points << 500.0 if self.has_full?
    points << 400.0 if self.has_newonly?
    points << 300.0 if self.has_waitlist?

    # add a point value for the day length
    points << ((self.longest_day[:duration]/3600.0))
    
    points.inject(:+)
  end

  def ranking
    @ranking ||= calc_ranking
  end

  # Calculate the start/end/duration of each day
  def calc_day_lengths
    tmp_day_lengths = []
    %w(M Tu W Th F Sa Su).each do |day|
      day_courses = @classes.select{|c|c.day_list.include?(day)}
      next if day_courses.empty?
      tmp_day_length = {
        day: day,
        start_time: day_courses.sort{|a,b| a.start_time <=> b.start_time}.first.start_time,
        end_time: day_courses.sort{|a,b| a.end_time <=> b.end_time}.last.end_time,
        duration: nil
      }

      tmp_day_length[:duration] = tmp_day_length[:end_time] - tmp_day_length[:start_time]

      tmp_day_lengths << tmp_day_length
    end
    tmp_day_lengths
  end

  def calc_longest_day
    day_lengths = self.calc_day_lengths.sort{|a,b|a[:duration] <=> b[:duration]}

    longest = day_lengths.last

    # Find all the other days that are this long, and show them as well
    longest[:days] = %w(M Tu W Th F Sa Su) & day_lengths.select{|d|d[:duration] == longest[:duration]}.map{|d|d[:day]}

    longest
  end

  def longest_day
    @longest_day ||= calc_longest_day
  end


  # This will return a code to determine WHY something is invalid
  def validity_response
    @validity_response ||= calc_validty_response
  end

  def valid?
    self.validity_response == :valid
  end

  def calc_validty_response

    # Required sections
    if @search.req_sections.size > 0
      return :required_sections if (@search.req_sections & self.ccodes).size == 0
    end

    # Required statuses
    unless @search.status_list.nil?
      return :statuses if (@classes.map(&:status) - @search.status_list).size > 0
    end

    # Required days
    if @search.days.size > 0
      return :days if (@classes.map(&:day_list).flatten - @search.days).size > 0
    end

    # Start time
    if @search.start_time
      return :start_time if @classes.select {|c| c.start_time < @search.start_time}.size > 0
    end

    # end time
    if @search.end_time
      return :end_time if @classes.select {|c| c.end_time > @search.end_time}.size > 0
    end

    if self.has_time_collisions?
      return :time_collisions
    end

    return :valid
  end

end