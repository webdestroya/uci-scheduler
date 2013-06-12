require 'open-uri'

namespace :import do

  desc "Import list of terms"
  task :terms => :environment do
    doc = Nokogiri::HTML(open("http://websoc.reg.uci.edu/perl/WebSoc"))
    #doc = Nokogiri::HTML(open("test/fixtures/terms.html"))

    elm = doc.css("select[name='YearTerm'] option")
    elm.each do |term_elm|
      term_code = term_elm['value']
      term_selected = term_elm['selected'].eql?("selected")
      term_name = term_elm.text.strip
      
      puts "#{term_code}: #{term_name} (#{term_selected})"

      term = Term.find_by_code(term_code)

      if term.nil?
        Term.create! code: term_code, name: term_name
      end


      if term_selected
        Term.find_by_code(term_code).set_current!
      end

    end
  end

  desc "Import courses"
  task :courses => :environment do
  end

  desc "Import list of buildings"
  task :buildings => :environment do
    doc = Nokogiri::HTML(open("http://www.reg.uci.edu/addl/campus/"))
    #doc = Nokogiri::HTML(open("test/fixtures/buildings.html"))

    nbsp = Nokogiri::HTML("&nbsp;").text


    elms = doc.css("table[cellspacing='10'] tr")
    elms.each do |row|
      abbr = row.css('td')[0].text.gsub(nbsp,'').strip
      #puts row.css('td')[1].text
      name = row.css('td')[2].text.gsub(nbsp,'').strip

      next if abbr.eql?("SOC") || abbr.eql?("")

      unless Building.where(abbr: abbr).exists?
        Building.create! abbr: abbr, name: name
      end


      puts "#{abbr}: #{name}"

    end

  end

  desc "Import departments"
  task :departments => :environment do
    #doc = Nokogiri::HTML(open("test/fixtures/terms.html"))
    doc = Nokogiri::HTML(open("http://websoc.reg.uci.edu/perl/WebSoc"))

    elms = doc.css("select[name='Dept'] option")
    elms.each do |dept_elm|
      code = dept_elm['value'].strip

      next if code.eql?("ALL")

      name = dept_elm.text.sub(code, '').gsub(/^[\. ]+/, '')



      unless Department.where(code: code).exists?
        Department.create! code: code, name: name
      end

      puts "#{code}: #{name}"
    end
  end

end
