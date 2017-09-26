class AddAssetFileMetaToMediaAssets < ActiveRecord::Migration
  def change
    add_column :media_assets, :asset_file_meta, :string
  end
end
