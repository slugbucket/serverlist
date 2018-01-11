json.array!(@service_levels) do |service_level|
  json.extract! service_level, :id, :name, :description
  json.url service_level_url(service_level, format: :json)
end
