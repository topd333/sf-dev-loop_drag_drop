class RenameRepeatModeToRepeatInfoInLoopCampaignHooks < ActiveRecord::Migration
  def change
  	rename_column :loop_campaign_hooks, :repeat_mode, :repeat_info
  end
end
