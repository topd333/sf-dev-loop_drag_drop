class AddAttachmentToMediaAssets < ActiveRecord::Migration
  def self.up
  	add_attachment :media_assets, :asset_file
  end

  def self.down
  	remove_attachment :media_assets, :asset_file
  end
end
