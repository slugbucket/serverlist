json.array!(@applications) do |application|
  json.extract! application, :id, :name, :application_type_id, :application_status_id, :vendor_id, :support_contact_id, :support_group_id, :description, :escalation_level_id, :impact_hour_id, :impact_level_id, :dr_shutdown_stage_id
  json.url application_url(application, format: :json)
end
