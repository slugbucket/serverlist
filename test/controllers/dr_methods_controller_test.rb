require 'test_helper'

class DrMethodsControllerTest < ActionController::TestCase
  setup do
    @dr_method = dr_methods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dr_methods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dr_method" do
    assert_difference('DrMethod.count') do
      post :create, dr_method: { description: @dr_method.description, name: @dr_method.name }
    end

    assert_redirected_to dr_method_path(assigns(:dr_method))
  end

  test "should show dr_method" do
    get :show, id: @dr_method
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dr_method
    assert_response :success
  end

  test "should update dr_method" do
    patch :update, id: @dr_method, dr_method: { description: @dr_method.description, name: @dr_method.name }
    assert_redirected_to dr_method_path(assigns(:dr_method))
  end

  test "should destroy dr_method" do
    assert_difference('DrMethod.count', -1) do
      delete :destroy, id: @dr_method
    end

    assert_redirected_to dr_methods_path
  end
end
