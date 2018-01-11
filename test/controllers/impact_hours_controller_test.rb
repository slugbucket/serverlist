require 'test_helper'

class ImpactHoursControllerTest < ActionController::TestCase
  setup do
    @impact_hour = impact_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:impact_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create impact_hour" do
    assert_difference('ImpactHour.count') do
      post :create, impact_hour: { description: @impact_hour.description, name: @impact_hour.name }
    end

    assert_redirected_to impact_hour_path(assigns(:impact_hour))
  end

  test "should show impact_hour" do
    get :show, id: @impact_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @impact_hour
    assert_response :success
  end

  test "should update impact_hour" do
    patch :update, id: @impact_hour, impact_hour: { description: @impact_hour.description, name: @impact_hour.name }
    assert_redirected_to impact_hour_path(assigns(:impact_hour))
  end

  test "should destroy impact_hour" do
    assert_difference('ImpactHour.count', -1) do
      delete :destroy, id: @impact_hour
    end

    assert_redirected_to impact_hours_path
  end
end
