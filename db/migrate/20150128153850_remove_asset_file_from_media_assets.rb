class RemoveAssetFileFromMediaAssets < ActiveRecord::Migration
  def change
  	remove_column :media_assets, :asset_file, :string
  end
end
