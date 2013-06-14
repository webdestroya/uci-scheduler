class SchedulesController < ApplicationController

  before_filter :setup_params

  # /schedules/:term/ccode,ccode,ccode,ccode
  def show
  end


  # Check the validity of a schedule
  # CHECK FOR TIME COLLISIONS
  def check
    response = {
      term: @term.code,
      term_id: @term.id,
      ccodes: @courses.map(&:ccode),
      valid: true
    }

    begin
      day_list = %w(M Tu W Th F Sa Su)
      tmp_days = {}
      day_list.each do |d|
        tmp_days[d] = []
        tmp_days[d].fill false, 0, 145
      end

      @courses.each do |course|

        start_time = (course.start_time.to_i - course.start_time.beginning_of_day.to_i) / 600
        end_time = (course.end_time.to_i - course.end_time.beginning_of_day.to_i) / 600

        course.day_list.each do |day|

          (start_time...end_time).each do |i|
            raise 'Invalid' if tmp_days[day][i]
          end

          (start_time...end_time).each do |i|
            tmp_days[day][i] = true
          end


        end # /daylist
      end # /courses

    rescue
      response[:valid] = false
    end

    render json: response

  end


  private

  def setup_params
    @term = Term.find_by_code(params[:term_code])
    ccodes = params[:ccodes].split(',')

    @courses = @term.courses.where(ccode: ccodes).includes(:department).order(:course_num)
  end
end
