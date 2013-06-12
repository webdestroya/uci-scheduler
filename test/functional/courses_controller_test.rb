require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { building_id: @course.building_id, ccode: @course.ccode, end_time: @course.end_time, friday: @course.friday, monday: @course.monday, room: @course.room, saturday: @course.saturday, start_time: @course.start_time, sunday: @course.sunday, teacher: @course.teacher, term_id: @course.term_id, thursday: @course.thursday, tuesday: @course.tuesday, type: @course.type, wednesday: @course.wednesday }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    put :update, id: @course, course: { building_id: @course.building_id, ccode: @course.ccode, end_time: @course.end_time, friday: @course.friday, monday: @course.monday, room: @course.room, saturday: @course.saturday, start_time: @course.start_time, sunday: @course.sunday, teacher: @course.teacher, term_id: @course.term_id, thursday: @course.thursday, tuesday: @course.tuesday, type: @course.type, wednesday: @course.wednesday }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
