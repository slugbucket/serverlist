require 'test_helper'

class DbReplicationsControllerTest < ActionController::TestCase
  setup do
    @db_replication = db_replications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_replications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_replication" do
    assert_difference('DbReplication.count') do
      post :create, db_replication: { application_id: @db_replication.application_id, db_repl_freq_id: @db_replication.db_repl_freq_id, db_repl_host: @db_replication.db_repl_host, db_repl_name: @db_replication.db_repl_name, db_repl_src: @db_replication.db_repl_src, db_repl_status_id: @db_replication.db_repl_status_id, db_repl_target: @db_replication.db_repl_target, db_repl_type: @db_replication.db_repl_type, description: @db_replication.description }
    end

    assert_redirected_to db_replication_path(assigns(:db_replication))
  end

  test "should show db_replication" do
    get :show, id: @db_replication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_replication
    assert_response :success
  end

  test "should update db_replication" do
    patch :update, id: @db_replication, db_replication: { application_id: @db_replication.application_id, db_repl_freq_id: @db_replication.db_repl_freq_id, db_repl_host: @db_replication.db_repl_host, db_repl_name: @db_replication.db_repl_name, db_repl_src: @db_replication.db_repl_src, db_repl_status_id: @db_replication.db_repl_status_id, db_repl_target: @db_replication.db_repl_target, db_repl_type: @db_replication.db_repl_type, description: @db_replication.description }
    assert_redirected_to db_replication_path(assigns(:db_replication))
  end

  test "should destroy db_replication" do
    assert_difference('DbReplication.count', -1) do
      delete :destroy, id: @db_replication
    end

    assert_redirected_to db_replications_path
  end
end
