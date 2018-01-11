require 'test_helper'

class PackageVersionsControllerTest < ActionController::TestCase
  setup do
    @package_version = package_versions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:package_versions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create package_version" do
    assert_difference('PackageVersion.count') do
      post :create, package_version: { name: @package_version.name, package_architecture_id: @package_version.package_architecture_id, package_id: @package_version.package_id }
    end

    assert_redirected_to package_version_path(assigns(:package_version))
  end

  test "should show package_version" do
    get :show, id: @package_version
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @package_version
    assert_response :success
  end

  test "should update package_version" do
    patch :update, id: @package_version, package_version: { name: @package_version.name, package_architecture_id: @package_version.package_architecture_id, package_id: @package_version.package_id }
    assert_redirected_to package_version_path(assigns(:package_version))
  end

  test "should destroy package_version" do
    assert_difference('PackageVersion.count', -1) do
      delete :destroy, id: @package_version
    end

    assert_redirected_to package_versions_path
  end
end
