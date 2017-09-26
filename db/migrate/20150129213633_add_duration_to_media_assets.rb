class AddDurationToMediaAssets < ActiveRecord::Migration
  def change
    add_column :media_assets, :duration, :integer
  end
end
