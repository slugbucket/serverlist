require 'test_helper'

class WarrantyTypesControllerTest < ActionController::TestCase
  setup do
    @warranty_type = warranty_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warranty_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warranty_type" do
    assert_difference('WarrantyType.count') do
      post :create, warranty_type: { description: @warranty_type.description, name: @warranty_type.name }
    end

    assert_redirected_to warranty_type_path(assigns(:warranty_type))
  end

  test "should show warranty_type" do
    get :show, id: @warranty_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @warranty_type
    assert_response :success
  end

  test "should update warranty_type" do
    patch :update, id: @warranty_type, warranty_type: { description: @warranty_type.description, name: @warranty_type.name }
    assert_redirected_to warranty_type_path(assigns(:warranty_type))
  end

  test "should destroy warranty_type" do
    assert_difference('WarrantyType.count', -1) do
      delete :destroy, id: @warranty_type
    end

    assert_redirected_to warranty_types_path
  end
end
