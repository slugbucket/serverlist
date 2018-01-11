json.array!(@db_repl_freqs) do |db_repl_freq|
  json.extract! db_repl_freq, :id, :name
  json.url db_repl_freq_url(db_repl_freq, format: :json)
end
