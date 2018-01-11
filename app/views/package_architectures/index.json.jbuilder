json.array!(@package_architectures) do |package_architecture|
  json.extract! package_architecture, :id, :name, :description
  json.url package_architecture_url(package_architecture, format: :json)
end
