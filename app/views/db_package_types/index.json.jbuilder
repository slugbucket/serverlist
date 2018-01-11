json.array!(@db_package_types) do |db_package_type|
  json.extract! db_package_type, :id, :name, :description
  json.url db_package_type_url(db_package_type, format: :json)
end
