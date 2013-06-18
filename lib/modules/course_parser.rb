class CourseParser



  def initialize(raw_data, dept)
    @data = raw_data
    @dept = dept
    @term = Term.current
    @has_parent_set = false

    @course_num = nil
    @course_name = nil

    @g_parent = nil
    @parent = ""

    @classes = {}
    %w(LEC DIS LAB ACT COL FLD RES STU TUT TAP SEM QIZ).each do |type|
      @classes[type] = []
    end

    @course_regex = %r{^
        (?<ccode>[0-9]{5})[ ]*
        (?<type>[A-Za-z]{3}) [ ]*
        (?<sect>[A-Z0-9]{1,3})[ ]* 
        (?<units>[0-9-]{1,4})[ ]*
        (?<teacher>.+?)[ ]+
        (?<days>[MWFTShua]+)[ ]*
        (?<start>[0-9p:]{4,6})-[ ]?
        (?<end>[0-9:p]{4,6})[ ]*
        (?<bldg>[*A-Z0-9]+)[ ]+
        (?<room>[A-Z 0-9]+?)[ ]+
        (?<max>[0-9]{1,3})[ ]+
        (?<enr>[0-9\/]+)[ ]+
        (?<waitlist>[na0-9\/]+)[ ]+
        (?<req>[0-9]{1,4})[ ]+
        (?<nor>[0-9]{1,4})[ ]+
        (?<rstr>[A-Za-z&]{0,5})[ ]+
        (?<status>Waitl|FULL|OPEN|NewOnly)
      $}x
  end


  def parse
    @data.each_line do |line|
      line.strip!

      if line =~ /^#{@dept.code}\s+([0-9A-Z]+)\s+(.+)$/i
        @course_num = $1.upcase.strip
        @course_name = $2.upcase.strip
        puts "#{@dept.code} #{@course_num}: #{@course_name}"
        @has_parent_set = false
      else
        self.parse_line line
      end
    end
  end # /parse


  def parse_line(line)
    r = @course_regex.match line

    return if r.nil?

    course = Course.new term_id: @term.id, 
      ccode: r[:ccode],
      department_id: @dept.id,
      course_num: @course_num,
      name: @course_name,
      teacher: r[:teacher],
      section: r[:sect],
      room: r[:room],
      status: r[:status]

    course.type = r[:type]
    course.days = r[:days]
    course.building = Building.find_by_abbr(r[:bldg])

    course.start_time = Chronic.parse r[:start], ambiguous_time_range: 8
    course.end_time = Chronic.parse r[:end], ambiguous_time_range: 8

    unless @has_parent_set
      @g_parent = course.type
      @parent = ""
      @has_parent_set = true
    end

    if course.type != @g_parent
      course.parent_course_id = @classes[@g_parent][@classes[@g_parent].size - 1] 
    end

    course.save!
    
    @classes[course.type] << course.id

  end # /parse_line

end