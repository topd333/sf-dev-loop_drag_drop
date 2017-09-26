class AddColumnsToOrganizations < ActiveRecord::Migration
  change_table :organizations do |t|
  	t.string :fname, :lname, :address1, :address2, :address3, :city, :province, :postalcode, :baddress1, :baddress2, :baddress3, :bcity, :bprovince, :bpostalcode
  end
end
