class RemoveMediaTypeFromMediaAssets < ActiveRecord::Migration
  def change
    remove_column :media_assets, :media_type, :string
  end
end
