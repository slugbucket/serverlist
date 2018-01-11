json.array!(@impact_hours) do |impact_hour|
  json.extract! impact_hour, :id, :name, :description
  json.url impact_hour_url(impact_hour, format: :json)
end
