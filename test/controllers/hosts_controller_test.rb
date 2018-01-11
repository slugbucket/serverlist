require 'test_helper'

class HostsControllerTest < ActionController::TestCase
  setup do
    @host = hosts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hosts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create host" do
    assert_difference('Host.count') do
      post :create, host: { active: @host.active, asset_tag: @host.asset_tag, commissioned: @host.commissioned, description: @host.description, dr_method_id: @host.dr_method_id, h_ad_domain: @host.h_ad_domain, h_location: @host.h_location, h_model: @host.h_model, h_oob_remote: @host.h_oob_remote, h_os: @host.h_os, name: @host.name, primary_use: @host.primary_use, runbook_alias: @host.runbook_alias, serialnum: @host.serialnum, service_level_id: @host.service_level_id, warranty: @host.warranty }
    end

    assert_redirected_to host_path(assigns(:host))
  end

  test "should show host" do
    get :show, id: @host
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @host
    assert_response :success
  end

  test "should update host" do
    patch :update, id: @host, host: { active: @host.active, asset_tag: @host.asset_tag, commissioned: @host.commissioned, description: @host.description, dr_method_id: @host.dr_method_id, h_ad_domain: @host.h_ad_domain, h_location: @host.h_location, h_model: @host.h_model, h_oob_remote: @host.h_oob_remote, h_os: @host.h_os, name: @host.name, primary_use: @host.primary_use, runbook_alias: @host.runbook_alias, serialnum: @host.serialnum, service_level_id: @host.service_level_id, warranty: @host.warranty }
    assert_redirected_to host_path(assigns(:host))
  end

  test "should destroy host" do
    assert_difference('Host.count', -1) do
      delete :destroy, id: @host
    end

    assert_redirected_to hosts_path
  end
end
