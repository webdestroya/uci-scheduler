class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @searches }
    end
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search = Search.find(params[:id])
    session[:search_id] = @search.id
  end

  # GET /searches/new
  # GET /searches/new.json
  def new
    @search = Search.new
    @search.term = Term.current
    @search.start_time = Chronic.parse("8:00am")
    @search.end_time = Chronic.parse("11:00pm")
    @search.status_list = %w(OPEN Waitl NewOnly)

    10.times { @search.search_courses.build }

  end

  # GET /searches/1/edit
  def edit
    @search = Search.find(params[:id])
    5.times { @search.search_courses.build }
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    if @search.save
      redirect_to @search, notice: 'Search was successfully created.'
    else
      5.times { @search.search_courses.build }
      render action: "new"
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    @search = Search.find(params[:id])

    @search.search_courses.destroy_all

    respond_to do |format|
      if @search.update_attributes(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def search_params
      params.require(:search).permit(:latest_time, {days: []}, :earliest_time, {status_list: []}, :term_id, :required_ccodes, {search_courses_attributes: [:department_id, :course_num]})
    end
end
