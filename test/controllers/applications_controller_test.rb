require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  setup do
    @application = applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application" do
    assert_difference('Application.count') do
      post :create, application: { application_status_id: @application.application_status_id, application_type: @application.application_type, description: @application.description, dr_shutdown_stage_id: @application.dr_shutdown_stage_id, escalation_level_id: @application.escalation_level_id, impact_hour_id: @application.impact_hour_id, impact_level_id: @application.impact_level_id, name: @application.name, support_contact_id: @application.support_contact_id, support_group_id: @application.support_group_id, vendor_id: @application.vendor_id }
    end

    assert_redirected_to application_path(assigns(:application))
  end

  test "should show application" do
    get :show, id: @application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application
    assert_response :success
  end

  test "should update application" do
    patch :update, id: @application, application: { application_status_id: @application.application_status_id, application_type: @application.application_type, description: @application.description, dr_shutdown_stage_id: @application.dr_shutdown_stage_id, escalation_level_id: @application.escalation_level_id, impact_hour_id: @application.impact_hour_id, impact_level_id: @application.impact_level_id, name: @application.name, support_contact_id: @application.support_contact_id, support_group_id: @application.support_group_id, vendor_id: @application.vendor_id }
    assert_redirected_to application_path(assigns(:application))
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete :destroy, id: @application
    end

    assert_redirected_to applications_path
  end
end
