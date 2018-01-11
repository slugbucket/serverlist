require 'test_helper'

class DrShutdownStagesControllerTest < ActionController::TestCase
  setup do
    @dr_shutdown_stage = dr_shutdown_stages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dr_shutdown_stages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dr_shutdown_stage" do
    assert_difference('DrShutdownStage.count') do
      post :create, dr_shutdown_stage: { description: @dr_shutdown_stage.description, name: @dr_shutdown_stage.name }
    end

    assert_redirected_to dr_shutdown_stage_path(assigns(:dr_shutdown_stage))
  end

  test "should show dr_shutdown_stage" do
    get :show, id: @dr_shutdown_stage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dr_shutdown_stage
    assert_response :success
  end

  test "should update dr_shutdown_stage" do
    patch :update, id: @dr_shutdown_stage, dr_shutdown_stage: { description: @dr_shutdown_stage.description, name: @dr_shutdown_stage.name }
    assert_redirected_to dr_shutdown_stage_path(assigns(:dr_shutdown_stage))
  end

  test "should destroy dr_shutdown_stage" do
    assert_difference('DrShutdownStage.count', -1) do
      delete :destroy, id: @dr_shutdown_stage
    end

    assert_redirected_to dr_shutdown_stages_path
  end
end
