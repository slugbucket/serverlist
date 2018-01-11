require 'test_helper'

class PackageArchitecturesControllerTest < ActionController::TestCase
  setup do
    @package_architecture = package_architectures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:package_architectures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create package_architecture" do
    assert_difference('PackageArchitecture.count') do
      post :create, package_architecture: { description: @package_architecture.description, name: @package_architecture.name }
    end

    assert_redirected_to package_architecture_path(assigns(:package_architecture))
  end

  test "should show package_architecture" do
    get :show, id: @package_architecture
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @package_architecture
    assert_response :success
  end

  test "should update package_architecture" do
    patch :update, id: @package_architecture, package_architecture: { description: @package_architecture.description, name: @package_architecture.name }
    assert_redirected_to package_architecture_path(assigns(:package_architecture))
  end

  test "should destroy package_architecture" do
    assert_difference('PackageArchitecture.count', -1) do
      delete :destroy, id: @package_architecture
    end

    assert_redirected_to package_architectures_path
  end
end
