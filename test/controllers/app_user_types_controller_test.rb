require 'test_helper'

class AppUserTypesControllerTest < ActionController::TestCase
  setup do
    @app_user_type = app_user_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:app_user_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create app_user_type" do
    assert_difference('AppUserType.count') do
      post :create, app_user_type: { description: @app_user_type.description, name: @app_user_type.name }
    end

    assert_redirected_to app_user_type_path(assigns(:app_user_type))
  end

  test "should show app_user_type" do
    get :show, id: @app_user_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @app_user_type
    assert_response :success
  end

  test "should update app_user_type" do
    patch :update, id: @app_user_type, app_user_type: { description: @app_user_type.description, name: @app_user_type.name }
    assert_redirected_to app_user_type_path(assigns(:app_user_type))
  end

  test "should destroy app_user_type" do
    assert_difference('AppUserType.count', -1) do
      delete :destroy, id: @app_user_type
    end

    assert_redirected_to app_user_types_path
  end
end
