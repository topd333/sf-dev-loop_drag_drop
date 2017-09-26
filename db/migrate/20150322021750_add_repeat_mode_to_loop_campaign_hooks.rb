class AddRepeatModeToLoopCampaignHooks < ActiveRecord::Migration
  def change
    add_column :loop_campaign_hooks, :repeat_mode, :integer, :limit => 1
  end
end
