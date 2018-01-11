json.array!(@db_packages) do |db_package|
  json.extract! db_package, :id, :name, :description, :db_package_type_id, :db_instance_id, :db_instance_db_name_id
  json.url db_package_url(db_package, format: :json)
end
