require 'test_helper'

class ApplicationTypesControllerTest < ActionController::TestCase
  setup do
    @application_type = application_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:application_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application_type" do
    assert_difference('ApplicationType.count') do
      post :create, application_type: { description: @application_type.description, name: @application_type.name }
    end

    assert_redirected_to application_type_path(assigns(:application_type))
  end

  test "should show application_type" do
    get :show, id: @application_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application_type
    assert_response :success
  end

  test "should update application_type" do
    patch :update, id: @application_type, application_type: { description: @application_type.description, name: @application_type.name }
    assert_redirected_to application_type_path(assigns(:application_type))
  end

  test "should destroy application_type" do
    assert_difference('ApplicationType.count', -1) do
      delete :destroy, id: @application_type
    end

    assert_redirected_to application_types_path
  end
end
