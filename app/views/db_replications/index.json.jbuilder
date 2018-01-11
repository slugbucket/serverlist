json.array!(@db_replications) do |db_replication|
  json.extract! db_replication, :id, :db_repl_name, :db_repl_type, :db_repl_host, :db_repl_src, :db_repl_target, :description, :db_repl_status_id, :db_repl_freq_id, :application_id
  json.url db_replication_url(db_replication, format: :json)
end
