json.array!(@db_clusters) do |db_cluster|
  json.extract! db_cluster, :id, :name
  json.url db_cluster_url(db_cluster, format: :json)
end
