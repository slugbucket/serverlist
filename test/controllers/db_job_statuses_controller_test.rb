require 'test_helper'

class DbJobStatusesControllerTest < ActionController::TestCase
  setup do
    @db_job_status = db_job_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_job_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_job_status" do
    assert_difference('DbJobStatus.count') do
      post :create, db_job_status: { name: @db_job_status.name }
    end

    assert_redirected_to db_job_status_path(assigns(:db_job_status))
  end

  test "should show db_job_status" do
    get :show, id: @db_job_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_job_status
    assert_response :success
  end

  test "should update db_job_status" do
    patch :update, id: @db_job_status, db_job_status: { name: @db_job_status.name }
    assert_redirected_to db_job_status_path(assigns(:db_job_status))
  end

  test "should destroy db_job_status" do
    assert_difference('DbJobStatus.count', -1) do
      delete :destroy, id: @db_job_status
    end

    assert_redirected_to db_job_statuses_path
  end
end
