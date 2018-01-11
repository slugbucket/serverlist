require 'test_helper'

class EscalationLevelsControllerTest < ActionController::TestCase
  setup do
    @escalation_level = escalation_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:escalation_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create escalation_level" do
    assert_difference('EscalationLevel.count') do
      post :create, escalation_level: { name: @escalation_level.name }
    end

    assert_redirected_to escalation_level_path(assigns(:escalation_level))
  end

  test "should show escalation_level" do
    get :show, id: @escalation_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @escalation_level
    assert_response :success
  end

  test "should update escalation_level" do
    patch :update, id: @escalation_level, escalation_level: { name: @escalation_level.name }
    assert_redirected_to escalation_level_path(assigns(:escalation_level))
  end

  test "should destroy escalation_level" do
    assert_difference('EscalationLevel.count', -1) do
      delete :destroy, id: @escalation_level
    end

    assert_redirected_to escalation_levels_path
  end
end
