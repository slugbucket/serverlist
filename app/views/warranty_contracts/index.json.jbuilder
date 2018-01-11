json.array!(@warranty_contracts) do |warranty_contract|
  json.extract! warranty_contract, :id, :name, :description, :vendor_id, :warranty_type_id, :expiry
  json.url warranty_contract_url(warranty_contract, format: :json)
end
