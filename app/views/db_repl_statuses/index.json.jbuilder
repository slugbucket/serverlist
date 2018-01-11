json.array!(@db_repl_statuses) do |db_repl_status|
  json.extract! db_repl_status, :id, :name
  json.url db_repl_status_url(db_repl_status, format: :json)
end
