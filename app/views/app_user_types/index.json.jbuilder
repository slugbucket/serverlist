json.array!(@app_user_types) do |app_user_type|
  json.extract! app_user_type, :id, :name, :description
  json.url app_user_type_url(app_user_type, format: :json)
end
