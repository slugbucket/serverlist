json.array!(@ad_domains) do |ad_domain|
  json.extract! ad_domain, :id, :name, :description, :active
  json.url ad_domain_url(ad_domain, format: :json)
end
