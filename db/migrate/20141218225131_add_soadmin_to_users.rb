class AddSoadminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :soadmin, :boolean, default: false
  end
end
