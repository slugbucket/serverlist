json.array!(@warranty_types) do |warranty_type|
  json.extract! warranty_type, :id, :name, :description
  json.url warranty_type_url(warranty_type, format: :json)
end
