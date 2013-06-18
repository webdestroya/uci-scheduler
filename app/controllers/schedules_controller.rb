class SchedulesController < ApplicationController

  before_filter :setup_params

  # /schedules/:term/ccode,ccode,ccode,ccode
  def show
    @schedules = []

    @search = nil
    if session[:search_id] 
      @search = Search.find(session[:search_id])
    end

    @calendar_info = {
      start_hour: @courses.map(&:start_time).map(&:hour).sort.first,
      end_hour: @courses.map(&:end_time).map(&:hour).sort.last,
      weekend: (%w(Sa Su) & @courses.map(&:day_list).flatten.uniq).size > 0,
      events: @courses.map(&:to_calendar_json).flatten,
    }
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
    # TODO: Use PossibleSchedule.valid?

    render json: response

  end


  private

  def setup_params
    @term = Term.find_by_code(params[:term_code])
    ccodes = params[:ccodes].split(',')

    @courses = @term.courses.where(ccode: ccodes).includes(:department).order(:course_num, :ccode)
  end
end
