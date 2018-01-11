json.array!(@db_instances) do |db_instance|
  json.extract! db_instance, :id, :name, :db_server_id, :server_app_id, :description
  json.url db_instance_url(db_instance, format: :json)
end
