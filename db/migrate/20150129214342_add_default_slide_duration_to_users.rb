class AddDefaultSlideDurationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_slide_duration, :integer, default: 20000
  end
end
