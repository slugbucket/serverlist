json.array!(@operation_levels) do |operation_level|
  json.extract! operation_level, :id, :name, :description
  json.url operation_level_url(operation_level, format: :json)
end
