require 'test_helper'

class DbNamesControllerTest < ActionController::TestCase
  setup do
    @db_name = db_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_name" do
    assert_difference('DbName.count') do
      post :create, db_name: { description: @db_name.description, name: @db_name.name }
    end

    assert_redirected_to db_name_path(assigns(:db_name))
  end

  test "should show db_name" do
    get :show, id: @db_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_name
    assert_response :success
  end

  test "should update db_name" do
    patch :update, id: @db_name, db_name: { description: @db_name.description, name: @db_name.name }
    assert_redirected_to db_name_path(assigns(:db_name))
  end

  test "should destroy db_name" do
    assert_difference('DbName.count', -1) do
      delete :destroy, id: @db_name
    end

    assert_redirected_to db_names_path
  end
end
