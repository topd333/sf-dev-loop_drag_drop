json.array!(@admin_pay_programs) do |admin_pay_program|
  json.extract! admin_pay_program, :id, :name, :description, :price, :available, :period
  json.url admin_pay_program_url(admin_pay_program, format: :json)
end
