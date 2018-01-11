require 'test_helper'

class AdDomainsControllerTest < ActionController::TestCase
  setup do
    @ad_domain = ad_domains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ad_domains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ad_domain" do
    assert_difference('AdDomain.count') do
      post :create, ad_domain: { active: @ad_domain.active, description: @ad_domain.description, name: @ad_domain.name }
    end

    assert_redirected_to ad_domain_path(assigns(:ad_domain))
  end

  test "should show ad_domain" do
    get :show, id: @ad_domain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ad_domain
    assert_response :success
  end

  test "should update ad_domain" do
    patch :update, id: @ad_domain, ad_domain: { active: @ad_domain.active, description: @ad_domain.description, name: @ad_domain.name }
    assert_redirected_to ad_domain_path(assigns(:ad_domain))
  end

  test "should destroy ad_domain" do
    assert_difference('AdDomain.count', -1) do
      delete :destroy, id: @ad_domain
    end

    assert_redirected_to ad_domains_path
  end
end
