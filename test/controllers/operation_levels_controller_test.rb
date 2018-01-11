require 'test_helper'

class OperationLevelsControllerTest < ActionController::TestCase
  setup do
    @operation_level = operation_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operation_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operation_level" do
    assert_difference('OperationLevel.count') do
      post :create, operation_level: { description: @operation_level.description, name: @operation_level.name }
    end

    assert_redirected_to operation_level_path(assigns(:operation_level))
  end

  test "should show operation_level" do
    get :show, id: @operation_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operation_level
    assert_response :success
  end

  test "should update operation_level" do
    patch :update, id: @operation_level, operation_level: { description: @operation_level.description, name: @operation_level.name }
    assert_redirected_to operation_level_path(assigns(:operation_level))
  end

  test "should destroy operation_level" do
    assert_difference('OperationLevel.count', -1) do
      delete :destroy, id: @operation_level
    end

    assert_redirected_to operation_levels_path
  end
end
