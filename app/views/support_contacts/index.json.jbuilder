json.array!(@support_contacts) do |support_contact|
  json.extract! support_contact, :id, :name, :email_addr, :telephone
  json.url support_contact_url(support_contact, format: :json)
end
