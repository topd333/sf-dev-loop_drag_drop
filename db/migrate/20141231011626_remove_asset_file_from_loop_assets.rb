class RemoveAssetFileFromLoopAssets < ActiveRecord::Migration
  def change
    remove_column :loop_assets, :asset_file, :string
  end
end
