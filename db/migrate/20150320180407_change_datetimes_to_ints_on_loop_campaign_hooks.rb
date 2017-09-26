class ChangeDatetimesToIntsOnLoopCampaignHooks < ActiveRecord::Migration
  def change
  	remove_column :loop_campaign_hooks, :start_time, :datetime
  	remove_column :loop_campaign_hooks, :end_time, :datetime

  	add_column :loop_campaign_hooks, :start_year, :integer, :limit => 2
  	add_column :loop_campaign_hooks, :start_month, :integer, :limit => 1
  	add_column :loop_campaign_hooks, :start_day, :integer, :limit => 1
  	add_column :loop_campaign_hooks, :start_hour, :integer, :limit => 1
  	add_column :loop_campaign_hooks, :start_minute, :integer, :limit => 1
  	add_column :loop_campaign_hooks, :start_second, :integer, :limit => 1

  	add_column :loop_campaign_hooks, :end_year, :integer, :limit => 2
  	add_column :loop_campaign_hooks, :end_month, :integer, :limit => 1
  	add_column :loop_campaign_hooks, :end_day, :integer, :limit => 1
  	add_column :loop_campaign_hooks, :end_hour, :integer, :limit => 1
  	add_column :loop_campaign_hooks, :end_minute, :integer, :limit => 1
  	add_column :loop_campaign_hooks, :end_second, :integer, :limit => 1
  end
end
