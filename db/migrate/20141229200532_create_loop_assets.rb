class CreateLoopAssets < ActiveRecord::Migration
  def change
    create_table :loop_assets do |t|
      t.string :asset_file
      t.integer :length
      t.string :displayname
      t.belongs_to :organization, index: true

      t.timestamps
    end
  end
end
