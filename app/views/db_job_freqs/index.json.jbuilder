json.array!(@db_job_freqs) do |db_job_freq|
  json.extract! db_job_freq, :id, :name
  json.url db_job_freq_url(db_job_freq, format: :json)
end
