json.array!(@db_repl_types) do |db_repl_type|
  json.extract! db_repl_type, :id, :name
  json.url db_repl_type_url(db_repl_type, format: :json)
end
