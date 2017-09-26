class AddDurationToSlideAsset < ActiveRecord::Migration
  def change
    add_column :slide_assets, :duration, :integer
  end
end
