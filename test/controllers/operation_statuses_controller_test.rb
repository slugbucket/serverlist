require 'test_helper'

class OperationStatusesControllerTest < ActionController::TestCase
  setup do
    @operation_status = operation_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operation_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operation_status" do
    assert_difference('OperationStatus.count') do
      post :create, operation_status: { description: @operation_status.description, name: @operation_status.name }
    end

    assert_redirected_to operation_status_path(assigns(:operation_status))
  end

  test "should show operation_status" do
    get :show, id: @operation_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operation_status
    assert_response :success
  end

  test "should update operation_status" do
    patch :update, id: @operation_status, operation_status: { description: @operation_status.description, name: @operation_status.name }
    assert_redirected_to operation_status_path(assigns(:operation_status))
  end

  test "should destroy operation_status" do
    assert_difference('OperationStatus.count', -1) do
      delete :destroy, id: @operation_status
    end

    assert_redirected_to operation_statuses_path
  end
end
