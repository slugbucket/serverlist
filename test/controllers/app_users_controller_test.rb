require 'test_helper'

class AppUsersControllerTest < ActionController::TestCase
  setup do
    @app_user = app_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:app_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create app_user" do
    assert_difference('AppUser.count') do
      post :create, app_user: { app_user_type: @app_user.app_user_type, description: @app_user.description, name: @app_user.name }
    end

    assert_redirected_to app_user_path(assigns(:app_user))
  end

  test "should show app_user" do
    get :show, id: @app_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @app_user
    assert_response :success
  end

  test "should update app_user" do
    patch :update, id: @app_user, app_user: { app_user_type: @app_user.app_user_type, description: @app_user.description, name: @app_user.name }
    assert_redirected_to app_user_path(assigns(:app_user))
  end

  test "should destroy app_user" do
    assert_difference('AppUser.count', -1) do
      delete :destroy, id: @app_user
    end

    assert_redirected_to app_users_path
  end
end
