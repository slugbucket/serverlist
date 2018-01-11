require 'test_helper'

class DbClustersControllerTest < ActionController::TestCase
  setup do
    @db_cluster = db_clusters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_clusters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_cluster" do
    assert_difference('DbCluster.count') do
      post :create, db_cluster: { name: @db_cluster.name }
    end

    assert_redirected_to db_cluster_path(assigns(:db_cluster))
  end

  test "should show db_cluster" do
    get :show, id: @db_cluster
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_cluster
    assert_response :success
  end

  test "should update db_cluster" do
    patch :update, id: @db_cluster, db_cluster: { name: @db_cluster.name }
    assert_redirected_to db_cluster_path(assigns(:db_cluster))
  end

  test "should destroy db_cluster" do
    assert_difference('DbCluster.count', -1) do
      delete :destroy, id: @db_cluster
    end

    assert_redirected_to db_clusters_path
  end
end
