require 'test_helper'

class DbInstancesControllerTest < ActionController::TestCase
  setup do
    @db_instance = db_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_instance" do
    assert_difference('DbInstance.count') do
      post :create, db_instance: { db_server_id: @db_instance.db_server_id, description: @db_instance.description, name: @db_instance.name, server_app_id: @db_instance.server_app_id }
    end

    assert_redirected_to db_instance_path(assigns(:db_instance))
  end

  test "should show db_instance" do
    get :show, id: @db_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_instance
    assert_response :success
  end

  test "should update db_instance" do
    patch :update, id: @db_instance, db_instance: { db_server_id: @db_instance.db_server_id, description: @db_instance.description, name: @db_instance.name, server_app_id: @db_instance.server_app_id }
    assert_redirected_to db_instance_path(assigns(:db_instance))
  end

  test "should destroy db_instance" do
    assert_difference('DbInstance.count', -1) do
      delete :destroy, id: @db_instance
    end

    assert_redirected_to db_instances_path
  end
end
