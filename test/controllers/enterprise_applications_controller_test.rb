require 'test_helper'

class EnterpriseApplicationsControllerTest < ActionController::TestCase
  setup do
    @enterprise_application = enterprise_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enterprise_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enterprise_application" do
    assert_difference('EnterpriseApplication.count') do
      post :create, enterprise_application: { description: @enterprise_application.description, name: @enterprise_application.name }
    end

    assert_redirected_to enterprise_application_path(assigns(:enterprise_application))
  end

  test "should show enterprise_application" do
    get :show, id: @enterprise_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enterprise_application
    assert_response :success
  end

  test "should update enterprise_application" do
    patch :update, id: @enterprise_application, enterprise_application: { description: @enterprise_application.description, name: @enterprise_application.name }
    assert_redirected_to enterprise_application_path(assigns(:enterprise_application))
  end

  test "should destroy enterprise_application" do
    assert_difference('EnterpriseApplication.count', -1) do
      delete :destroy, id: @enterprise_application
    end

    assert_redirected_to enterprise_applications_path
  end
end
