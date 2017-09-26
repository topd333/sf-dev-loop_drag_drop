class AddUuidToSlideAssets < ActiveRecord::Migration
  def change
    add_column :slide_assets, :uuid, :string
  end
end
