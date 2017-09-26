class AddLoopAssetToPlayer < ActiveRecord::Migration
  def change
    add_reference :players, :loop_asset, index: true
  end
end
