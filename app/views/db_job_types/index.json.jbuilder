json.array!(@db_job_types) do |db_job_type|
  json.extract! db_job_type, :id, :name
  json.url db_job_type_url(db_job_type, format: :json)
end
