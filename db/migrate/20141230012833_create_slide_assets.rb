class CreateSlideAssets < ActiveRecord::Migration
  def change
    create_table :slide_assets do |t|
      t.belongs_to :loop_asset, index: true
      t.belongs_to :organization, index: true
      t.belongs_to :slide_template, index: true

      t.timestamps
    end
  end
end
