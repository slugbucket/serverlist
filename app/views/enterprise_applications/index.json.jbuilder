json.array!(@enterprise_applications) do |enterprise_application|
  json.extract! enterprise_application, :id, :name, :description
  json.url enterprise_application_url(enterprise_application, format: :json)
end
