require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  setup do
    @search = searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search" do
    assert_difference('Search.count') do
      post :create, search: { courses_list: @search.courses_list, end_time: @search.end_time, friday: @search.friday, monday: @search.monday, saturday: @search.saturday, start_time: @search.start_time, statuses: @search.statuses, sunday: @search.sunday, term_id: @search.term_id, thursday: @search.thursday, tuesday: @search.tuesday, wednesday: @search.wednesday }
    end

    assert_redirected_to search_path(assigns(:search))
  end

  test "should show search" do
    get :show, id: @search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @search
    assert_response :success
  end

  test "should update search" do
    put :update, id: @search, search: { courses_list: @search.courses_list, end_time: @search.end_time, friday: @search.friday, monday: @search.monday, saturday: @search.saturday, start_time: @search.start_time, statuses: @search.statuses, sunday: @search.sunday, term_id: @search.term_id, thursday: @search.thursday, tuesday: @search.tuesday, wednesday: @search.wednesday }
    assert_redirected_to search_path(assigns(:search))
  end

  test "should destroy search" do
    assert_difference('Search.count', -1) do
      delete :destroy, id: @search
    end

    assert_redirected_to searches_path
  end
end
