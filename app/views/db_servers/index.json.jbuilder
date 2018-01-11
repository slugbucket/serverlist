json.array!(@db_servers) do |db_server|
  json.extract! db_server, :id, :name, :description, :db_cluster_id
  json.url db_server_url(db_server, format: :json)
end
