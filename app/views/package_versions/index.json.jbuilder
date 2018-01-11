json.array!(@package_versions) do |package_version|
  json.extract! package_version, :id, :name, :package_id, :package_architecture_id
  json.url package_version_url(package_version, format: :json)
end
