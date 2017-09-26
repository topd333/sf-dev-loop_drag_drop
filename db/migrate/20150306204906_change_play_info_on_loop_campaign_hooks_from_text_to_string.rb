class ChangePlayInfoOnLoopCampaignHooksFromTextToString < ActiveRecord::Migration
  def self.up
  	change_column :loop_campaign_hooks, :play_info, :string
  end

  def self.down
  	change_column :loop_campaign_hooks, :play_info, :text
  end
end
