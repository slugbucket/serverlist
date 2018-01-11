json.array!(@impact_levels) do |impact_level|
  json.extract! impact_level, :id, :name, :description
  json.url impact_level_url(impact_level, format: :json)
end
