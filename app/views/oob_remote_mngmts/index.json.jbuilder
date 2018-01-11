json.array!(@oob_remote_mngmts) do |oob_remote_mngmt|
  json.extract! oob_remote_mngmt, :id, :name, :description
  json.url oob_remote_mngmt_url(oob_remote_mngmt, format: :json)
end
