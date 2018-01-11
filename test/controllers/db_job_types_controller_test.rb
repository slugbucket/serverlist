require 'test_helper'

class DbJobTypesControllerTest < ActionController::TestCase
  setup do
    @db_job_type = db_job_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_job_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_job_type" do
    assert_difference('DbJobType.count') do
      post :create, db_job_type: { name: @db_job_type.name }
    end

    assert_redirected_to db_job_type_path(assigns(:db_job_type))
  end

  test "should show db_job_type" do
    get :show, id: @db_job_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_job_type
    assert_response :success
  end

  test "should update db_job_type" do
    patch :update, id: @db_job_type, db_job_type: { name: @db_job_type.name }
    assert_redirected_to db_job_type_path(assigns(:db_job_type))
  end

  test "should destroy db_job_type" do
    assert_difference('DbJobType.count', -1) do
      delete :destroy, id: @db_job_type
    end

    assert_redirected_to db_job_types_path
  end
end
