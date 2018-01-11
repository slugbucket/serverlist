json.array!(@app_users) do |app_user|
  json.extract! app_user, :id, :name, :app_user_type, :description
  json.url app_user_url(app_user, format: :json)
end
