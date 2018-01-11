json.array!(@operation_statuses) do |operation_status|
  json.extract! operation_status, :id, :name, :description
  json.url operation_status_url(operation_status, format: :json)
end
