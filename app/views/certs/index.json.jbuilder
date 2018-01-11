json.array!(@certs) do |cert|
  json.extract! cert, :id, :name, :description, :cert_type_id, :vendor_id, :expiry, :application_id
  json.url cert_url(cert, format: :json)
end
