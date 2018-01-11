require 'test_helper'

class ServerAppsControllerTest < ActionController::TestCase
  setup do
    @server_app = server_apps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:server_apps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create server_app" do
    assert_difference('ServerApp.count') do
      post :create, server_app: { description: @server_app.description, name: @server_app.name, vendor_id: @server_app.vendor_id, warranty_contract_id: @server_app.warranty_contract_id }
    end

    assert_redirected_to server_app_path(assigns(:server_app))
  end

  test "should show server_app" do
    get :show, id: @server_app
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @server_app
    assert_response :success
  end

  test "should update server_app" do
    patch :update, id: @server_app, server_app: { description: @server_app.description, name: @server_app.name, vendor_id: @server_app.vendor_id, warranty_contract_id: @server_app.warranty_contract_id }
    assert_redirected_to server_app_path(assigns(:server_app))
  end

  test "should destroy server_app" do
    assert_difference('ServerApp.count', -1) do
      delete :destroy, id: @server_app
    end

    assert_redirected_to server_apps_path
  end
end
