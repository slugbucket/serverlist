require 'test_helper'

class WarrantyContractsControllerTest < ActionController::TestCase
  setup do
    @warranty_contract = warranty_contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warranty_contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warranty_contract" do
    assert_difference('WarrantyContract.count') do
      post :create, warranty_contract: { description: @warranty_contract.description, expiry: @warranty_contract.expiry, name: @warranty_contract.name, vendor_id: @warranty_contract.vendor_id, warranty_type_id: @warranty_contract.warranty_type_id }
    end

    assert_redirected_to warranty_contract_path(assigns(:warranty_contract))
  end

  test "should show warranty_contract" do
    get :show, id: @warranty_contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @warranty_contract
    assert_response :success
  end

  test "should update warranty_contract" do
    patch :update, id: @warranty_contract, warranty_contract: { description: @warranty_contract.description, expiry: @warranty_contract.expiry, name: @warranty_contract.name, vendor_id: @warranty_contract.vendor_id, warranty_type_id: @warranty_contract.warranty_type_id }
    assert_redirected_to warranty_contract_path(assigns(:warranty_contract))
  end

  test "should destroy warranty_contract" do
    assert_difference('WarrantyContract.count', -1) do
      delete :destroy, id: @warranty_contract
    end

    assert_redirected_to warranty_contracts_path
  end
end
