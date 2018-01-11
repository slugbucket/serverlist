json.array!(@db_job_statuses) do |db_job_status|
  json.extract! db_job_status, :id, :name
  json.url db_job_status_url(db_job_status, format: :json)
end
