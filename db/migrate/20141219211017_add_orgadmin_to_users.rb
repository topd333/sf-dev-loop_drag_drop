class AddOrgadminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :orgadmin, :boolean, default: false
  end
end
