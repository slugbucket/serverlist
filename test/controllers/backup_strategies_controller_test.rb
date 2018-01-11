require 'test_helper'

class BackupStrategiesControllerTest < ActionController::TestCase
  setup do
    @backup_strategy = backup_strategies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backup_strategies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backup_strategy" do
    assert_difference('BackupStrategy.count') do
      post :create, backup_strategy: { description: @backup_strategy.description, name: @backup_strategy.name }
    end

    assert_redirected_to backup_strategy_path(assigns(:backup_strategy))
  end

  test "should show backup_strategy" do
    get :show, id: @backup_strategy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backup_strategy
    assert_response :success
  end

  test "should update backup_strategy" do
    patch :update, id: @backup_strategy, backup_strategy: { description: @backup_strategy.description, name: @backup_strategy.name }
    assert_redirected_to backup_strategy_path(assigns(:backup_strategy))
  end

  test "should destroy backup_strategy" do
    assert_difference('BackupStrategy.count', -1) do
      delete :destroy, id: @backup_strategy
    end

    assert_redirected_to backup_strategies_path
  end
end
