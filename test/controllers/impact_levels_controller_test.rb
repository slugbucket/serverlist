require 'test_helper'

class ImpactLevelsControllerTest < ActionController::TestCase
  setup do
    @impact_level = impact_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:impact_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create impact_level" do
    assert_difference('ImpactLevel.count') do
      post :create, impact_level: { description: @impact_level.description, name: @impact_level.name }
    end

    assert_redirected_to impact_level_path(assigns(:impact_level))
  end

  test "should show impact_level" do
    get :show, id: @impact_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @impact_level
    assert_response :success
  end

  test "should update impact_level" do
    patch :update, id: @impact_level, impact_level: { description: @impact_level.description, name: @impact_level.name }
    assert_redirected_to impact_level_path(assigns(:impact_level))
  end

  test "should destroy impact_level" do
    assert_difference('ImpactLevel.count', -1) do
      delete :destroy, id: @impact_level
    end

    assert_redirected_to impact_levels_path
  end
end
