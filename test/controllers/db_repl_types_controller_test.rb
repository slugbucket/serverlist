require 'test_helper'

class DbReplTypesControllerTest < ActionController::TestCase
  setup do
    @db_repl_type = db_repl_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_repl_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_repl_type" do
    assert_difference('DbReplType.count') do
      post :create, db_repl_type: { name: @db_repl_type.name }
    end

    assert_redirected_to db_repl_type_path(assigns(:db_repl_type))
  end

  test "should show db_repl_type" do
    get :show, id: @db_repl_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_repl_type
    assert_response :success
  end

  test "should update db_repl_type" do
    patch :update, id: @db_repl_type, db_repl_type: { name: @db_repl_type.name }
    assert_redirected_to db_repl_type_path(assigns(:db_repl_type))
  end

  test "should destroy db_repl_type" do
    assert_difference('DbReplType.count', -1) do
      delete :destroy, id: @db_repl_type
    end

    assert_redirected_to db_repl_types_path
  end
end
