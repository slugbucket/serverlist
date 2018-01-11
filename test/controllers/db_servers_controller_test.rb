require 'test_helper'

class DbServersControllerTest < ActionController::TestCase
  setup do
    @db_server = db_servers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_servers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_server" do
    assert_difference('DbServer.count') do
      post :create, db_server: { db_cluster_id: @db_server.db_cluster_id, description: @db_server.description, name: @db_server.name }
    end

    assert_redirected_to db_server_path(assigns(:db_server))
  end

  test "should show db_server" do
    get :show, id: @db_server
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_server
    assert_response :success
  end

  test "should update db_server" do
    patch :update, id: @db_server, db_server: { db_cluster_id: @db_server.db_cluster_id, description: @db_server.description, name: @db_server.name }
    assert_redirected_to db_server_path(assigns(:db_server))
  end

  test "should destroy db_server" do
    assert_difference('DbServer.count', -1) do
      delete :destroy, id: @db_server
    end

    assert_redirected_to db_servers_path
  end
end
