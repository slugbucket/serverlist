json.array!(@dr_shutdown_stages) do |dr_shutdown_stage|
  json.extract! dr_shutdown_stage, :id, :name, :description
  json.url dr_shutdown_stage_url(dr_shutdown_stage, format: :json)
end
