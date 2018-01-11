json.array!(@escalation_levels) do |escalation_level|
  json.extract! escalation_level, :id, :name
  json.url escalation_level_url(escalation_level, format: :json)
end
