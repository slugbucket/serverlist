require 'test_helper'

class SupportContactsControllerTest < ActionController::TestCase
  setup do
    @support_contact = support_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:support_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create support_contact" do
    assert_difference('SupportContact.count') do
      post :create, support_contact: { email_addr: @support_contact.email_addr, name: @support_contact.name, telephone: @support_contact.telephone }
    end

    assert_redirected_to support_contact_path(assigns(:support_contact))
  end

  test "should show support_contact" do
    get :show, id: @support_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @support_contact
    assert_response :success
  end

  test "should update support_contact" do
    patch :update, id: @support_contact, support_contact: { email_addr: @support_contact.email_addr, name: @support_contact.name, telephone: @support_contact.telephone }
    assert_redirected_to support_contact_path(assigns(:support_contact))
  end

  test "should destroy support_contact" do
    assert_difference('SupportContact.count', -1) do
      delete :destroy, id: @support_contact
    end

    assert_redirected_to support_contacts_path
  end
end
