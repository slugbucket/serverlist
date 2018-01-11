require 'test_helper'

class OobRemoteMngmtsControllerTest < ActionController::TestCase
  setup do
    @oob_remote_mngmt = oob_remote_mngmts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oob_remote_mngmts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oob_remote_mngmt" do
    assert_difference('OobRemoteMngmt.count') do
      post :create, oob_remote_mngmt: { description: @oob_remote_mngmt.description, name: @oob_remote_mngmt.name }
    end

    assert_redirected_to oob_remote_mngmt_path(assigns(:oob_remote_mngmt))
  end

  test "should show oob_remote_mngmt" do
    get :show, id: @oob_remote_mngmt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @oob_remote_mngmt
    assert_response :success
  end

  test "should update oob_remote_mngmt" do
    patch :update, id: @oob_remote_mngmt, oob_remote_mngmt: { description: @oob_remote_mngmt.description, name: @oob_remote_mngmt.name }
    assert_redirected_to oob_remote_mngmt_path(assigns(:oob_remote_mngmt))
  end

  test "should destroy oob_remote_mngmt" do
    assert_difference('OobRemoteMngmt.count', -1) do
      delete :destroy, id: @oob_remote_mngmt
    end

    assert_redirected_to oob_remote_mngmts_path
  end
end
