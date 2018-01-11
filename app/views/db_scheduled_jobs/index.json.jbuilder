json.array!(@db_scheduled_jobs) do |db_scheduled_job|
  json.extract! db_scheduled_job, :id, :name, :db_instance_db_name, :db_job_type, :db_job_host, :description, :db_job_status, :db_job_freq, :db_job_owner, :application_id
  json.url db_scheduled_job_url(db_scheduled_job, format: :json)
end
