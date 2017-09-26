class RemoveThumbnailFileFromMediaAssets < ActiveRecord::Migration
  def change
    remove_column :media_assets, :thumbnail_file, :string
  end
end
