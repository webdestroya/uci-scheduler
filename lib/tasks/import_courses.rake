require 'open-uri'
require 'net/http'

namespace :import do

desc "Import courses"
task :courses => :environment do
  Department.active.each do |dept|
    # puts "#{dept.id} #{dept.code} #{dept.name}"
    Rake::Task["import:dept_courses"].invoke(dept.code)
    Rake::Task["import:dept_courses"].reenable
  end
end


desc "Import courses for specific dept [\"DEPT\"]"
task :dept_courses, [:dept] => :environment do |t, args|
  dept_abbr = args[:dept].upcase


  dept = Department.find_by_code(dept_abbr)
  puts "IMPORTING COURSES FOR #{dept.name}"
  if true
    uri = URI('http://websoc.reg.uci.edu/perl/WebSoc')
    res = Net::HTTP.post_form(uri, 
      'Breadth' => 'ANY',
      'CancelledCourses' => 'Exclude',
      'ClassType' => 'ALL',
      'CourseCodes' => '',
      'CourseNum' => '',
      'CourseTitle' => '',
      'Days' => '',
      'Dept' => dept.code,
      'Division' => 'ANY',
      'EndTime' => '',
      'FontSize' => '100',
      'FullCourses' => 'ANY',
      'InstrName' => '',
      'MaxCap' => '',
      'StartTime' => '',
      'Submit' => 'Display Text Results',
      'Units' => '',
      'YearTerm' => Term.current.code
      )
    body = res.body
  else 
    body = File.read("test/fixtures/ics.txt")
  end

  Course.where(term_id: Term.current.id).where(department_id: dept.id).destroy_all

  parser = CourseParser.new body, dept

  parser.parse

end # end dept_courses

end