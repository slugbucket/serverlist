json.array!(@support_groups) do |support_group|
  json.extract! support_group, :id, :name, :description
  json.url support_group_url(support_group, format: :json)
end
