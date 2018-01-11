require 'test_helper'

class DbReplStatusesControllerTest < ActionController::TestCase
  setup do
    @db_repl_status = db_repl_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_repl_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_repl_status" do
    assert_difference('DbReplStatus.count') do
      post :create, db_repl_status: { name: @db_repl_status.name }
    end

    assert_redirected_to db_repl_status_path(assigns(:db_repl_status))
  end

  test "should show db_repl_status" do
    get :show, id: @db_repl_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_repl_status
    assert_response :success
  end

  test "should update db_repl_status" do
    patch :update, id: @db_repl_status, db_repl_status: { name: @db_repl_status.name }
    assert_redirected_to db_repl_status_path(assigns(:db_repl_status))
  end

  test "should destroy db_repl_status" do
    assert_difference('DbReplStatus.count', -1) do
      delete :destroy, id: @db_repl_status
    end

    assert_redirected_to db_repl_statuses_path
  end
end
