module SearchesHelper

  def statuses(status_array)
    output = [status_array].flatten.collect do |status|
      "<span class=\"status status-#{status.downcase}\">#{status}</span>"
    end
    output.join(', ').html_safe
  end

  def longest_day(sched)
    long_day = sched.longest_day
    day = long_day[:days].join ','
    start_time = long_day[:start_time].strftime('%l:%M%P').strip.gsub(/:00|m/, '')
    end_time = long_day[:end_time].strftime('%l:%M%P').strip.gsub(/:00|m/, '')
    duration = distance_of_time_in_words long_day[:duration]

    "#{day} #{start_time}-#{end_time} (#{duration})"
  end
end
