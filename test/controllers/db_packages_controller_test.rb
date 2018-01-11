require 'test_helper'

class DbPackagesControllerTest < ActionController::TestCase
  setup do
    @db_package = db_packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_package" do
    assert_difference('DbPackage.count') do
      post :create, db_package: { db_instance_db_name_id: @db_package.db_instance_db_name_id, db_instance_id: @db_package.db_instance_id, db_package_type_id: @db_package.db_package_type_id, description: @db_package.description, name: @db_package.name }
    end

    assert_redirected_to db_package_path(assigns(:db_package))
  end

  test "should show db_package" do
    get :show, id: @db_package
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_package
    assert_response :success
  end

  test "should update db_package" do
    patch :update, id: @db_package, db_package: { db_instance_db_name_id: @db_package.db_instance_db_name_id, db_instance_id: @db_package.db_instance_id, db_package_type_id: @db_package.db_package_type_id, description: @db_package.description, name: @db_package.name }
    assert_redirected_to db_package_path(assigns(:db_package))
  end

  test "should destroy db_package" do
    assert_difference('DbPackage.count', -1) do
      delete :destroy, id: @db_package
    end

    assert_redirected_to db_packages_path
  end
end
