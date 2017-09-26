class AddDispalynameToSlideAssets < ActiveRecord::Migration
  def change
    add_column :slide_assets, :displayname, :string
  end
end
