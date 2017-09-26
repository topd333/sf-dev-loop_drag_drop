class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :displayname
      t.belongs_to :organization, index: true
      t.string :uuid
      t.timestamps
    end

    create_table :loop_campaign_hooks do |t|
    	t.belongs_to :loop_asset, index: true
    	t.belongs_to :campaign, index: true
    	t.text :play_info
      t.timestamps
    end
  end
end
