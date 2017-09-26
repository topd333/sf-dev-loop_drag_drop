class CreateMediaAssets < ActiveRecord::Migration
  def change
    create_table :media_assets do |t|
      t.belongs_to :organization, index: true
      t.string :asset_file
      t.string :thumbnail_file
      t.string :media_type
      t.string :displayname
      t.integer :size

      t.timestamps
    end
  end
end
