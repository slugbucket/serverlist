json.array!(@backup_strategies) do |backup_strategy|
  json.extract! backup_strategy, :id, :name, :description
  json.url backup_strategy_url(backup_strategy, format: :json)
end
