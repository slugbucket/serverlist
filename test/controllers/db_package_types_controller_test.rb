require 'test_helper'

class DbPackageTypesControllerTest < ActionController::TestCase
  setup do
    @db_package_type = db_package_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_package_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_package_type" do
    assert_difference('DbPackageType.count') do
      post :create, db_package_type: { description: @db_package_type.description, name: @db_package_type.name }
    end

    assert_redirected_to db_package_type_path(assigns(:db_package_type))
  end

  test "should show db_package_type" do
    get :show, id: @db_package_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_package_type
    assert_response :success
  end

  test "should update db_package_type" do
    patch :update, id: @db_package_type, db_package_type: { description: @db_package_type.description, name: @db_package_type.name }
    assert_redirected_to db_package_type_path(assigns(:db_package_type))
  end

  test "should destroy db_package_type" do
    assert_difference('DbPackageType.count', -1) do
      delete :destroy, id: @db_package_type
    end

    assert_redirected_to db_package_types_path
  end
end
