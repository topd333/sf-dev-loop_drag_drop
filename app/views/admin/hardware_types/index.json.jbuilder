json.array!(@admin_hardware_types) do |admin_hardware_type|
  json.extract! admin_hardware_type, :id, :model_number, :description
  json.url admin_hardware_type_url(admin_hardware_type, format: :json)
end
