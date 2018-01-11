json.array!(@db_names) do |db_name|
  json.extract! db_name, :id, :name, :description
  json.url db_name_url(db_name, format: :json)
end
