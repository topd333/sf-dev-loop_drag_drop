class AddStartAndEndToLoopCampaignHooks < ActiveRecord::Migration
  def change
    add_column :loop_campaign_hooks, :start_time, :datetime
    add_column :loop_campaign_hooks, :end_time, :datetime
  end
end
