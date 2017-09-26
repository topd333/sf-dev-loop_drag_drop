class RemoveLoopAssetIdFromPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :loop_asset_id, :integer
  end
end
