json.array!(@dr_methods) do |dr_method|
  json.extract! dr_method, :id, :name, :description
  json.url dr_method_url(dr_method, format: :json)
end
