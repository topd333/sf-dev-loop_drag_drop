class AddPositionToSlideAssets < ActiveRecord::Migration
  def change
    add_column :slide_assets, :position, :integer
  end
end
