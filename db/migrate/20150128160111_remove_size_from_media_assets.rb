class RemoveSizeFromMediaAssets < ActiveRecord::Migration
  def change
    remove_column :media_assets, :size, :integer
  end
end
