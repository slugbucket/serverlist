json.array!(@server_apps) do |server_app|
  json.extract! server_app, :id, :name, :description, :vendor_id, :warranty_contract_id
  json.url server_app_url(server_app, format: :json)
end
