class AddCampaignToPlayers < ActiveRecord::Migration
  def change
    add_reference :players, :campaign, index: true
  end
end
